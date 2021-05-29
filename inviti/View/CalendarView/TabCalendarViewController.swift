//
//  TabCalendarViewController.swift
//  inviti
//
//  Created by Hannah.C on 24.05.21.
//

import UIKit
import JKCalendar
import Firebase
import FirebaseFirestoreSwift
import EasyRefresher


class TabCalendarViewController: UIViewController {

    let lightGrayColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    let lightColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
    var selectDay: JKDay = JKDay(date: Date()) {
        didSet {
            self.calendarTableView.reloadData()

        }
    }

    var viewModel = CalendarVMController()

    var eventViewModels: [EventViewModel]?{
        didSet {
            self.calendarTableView.calendar.reloadData()
        }
    }

    @IBOutlet weak var calendarTableView: JKCalendarTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        calendarTableView.nativeDelegate = self
        calendarTableView.calendar.delegate = self
        calendarTableView.calendar.dataSource = self

        calendarTableView.backgroundColor = lightColor

        calendarTableView.calendar.focusWeek = selectDay.weekOfMonth - 1

        viewModel.eventViewModels.bind { [weak self] events in

            self?.viewModel.onRefresh()
            self?.calendarTableView.reloadData()
            self!.calendarTableView.calendar.reloadData()

        }

        viewModel.refreshView = { [weak self] () in
            DispatchQueue.main.async {
                self?.calendarTableView.reloadData()
            }
        }

        viewModel.fetchData()

        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
        calendarTableView.register(nib, forCellReuseIdentifier: "eventTableViewCell")

        setupRefresher() 
    }
    

    func setupRefresher() {
        self.calendarTableView.refresh.header = RefreshHeader(delegate: self)

        calendarTableView.refresh.header.addRefreshClosure { [weak self] in
            self?.viewModel.fetchData()
            self?.calendarTableView.refresh.header.endRefreshing()
        }
    }

}

extension TabCalendarViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventViewModels?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventTableViewCell", for: indexPath) as! EventTableViewCell

        guard let newViewModels = eventViewModels?[indexPath.row] else { return cell }

            cell.setup(vm: newViewModels)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

}


extension TabCalendarViewController: JKCalendarDelegate {

    func calendar(_ calendar: JKCalendar, didTouch day: JKDay) {
        selectDay = day
        calendar.focusWeek = day < calendar.month ? 0: day > calendar.month ? calendar.month.weeksCount - 1: day.weekOfMonth - 1

        let theDay = Date.intDateFormatter.string(from: self.selectDay.date)
        eventViewModels = viewModel.createSelectedData(in: viewModel.eventViewModels.value, selectedDate: theDay)



        self.calendarTableView.reloadData()
    }


    func heightOfFooterView(in claendar: JKCalendar) -> CGFloat {
        return 10
    }

    func viewOfFooter(in calendar: JKCalendar) -> UIView? {
        let view = UIView()
        let line = UIView(frame: CGRect(x: 8, y: 9, width: calendar.frame.width - 16, height: 1))
        line.backgroundColor = lightGrayColor
        view.addSubview(line)
        return view
    }
}

extension TabCalendarViewController: JKCalendarDataSource {

    func calendar(_ calendar: JKCalendar, marksWith month: JKMonth) -> [JKCalendarMark]? {

        let markColor = UIColor(red: 1, green: 0.3647, blue: 0, alpha: 1.0)

        let todayColor = UIColor(red: 1, green: 0.8432, blue: 0.2784, alpha: 1.0)

        var marks: [JKCalendarMark] = []

        let today = JKDay(date: Date())

        var marksDay = viewModel.createMarksData()

        if selectDay == month{
            marks.append(JKCalendarMark(type: .circle,
                                        day: selectDay,
                                        color: markColor))
        }

        if today == month{
            marks.append(JKCalendarMark(type: .hollowCircle,
                                        day: today,
                                        color: todayColor))
        }


        for i in marksDay {
            if i == month {
            marks.append(JKCalendarMark(type: .dot,
                                        day: i,
                                        color: todayColor))
        }

        }
            return marks
    }
}


extension TabCalendarViewController: RefreshDelegate {

    func refresherDidRefresh(_ refresher: Refresher) {
        print("refresherDidRefresh")
    }
}
