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

    let markColor = UIColor(red: 1, green: 0.3647, blue: 0, alpha: 1.0)

    var selectDay: JKDay = JKDay(date: Date()) {
        didSet {
            self.calendarTableView.reloadData()

        }
    }

    var eventTime: JKDay = JKDay(date: Date())

    var viewModel = CalendarViewModel()

    var events: [EventViewModel]?

    var options: [OptionsData] = [] {
        didSet {

            self.options.sort(by: <)
            calendarTableView.reloadData()
        }
    }

    @IBOutlet weak var calendarTableView: JKCalendarTableView!

    private var location = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        calendarTableView.nativeDelegate = self
        calendarTableView.calendar.delegate = self
        calendarTableView.calendar.dataSource = self
        calendarTableView.delegate = self
        calendarTableView.dataSource = self

        calendarTableView.calendar.focusWeek = selectDay.weekOfMonth - 1

        viewModel.eventViewModels.bind { [weak self] events in

            self?.viewModel.onRefresh()
            self?.calendarTableView.reloadData()

        }

//        viewModel.selectedViewModels.bind { [weak self] events in
//
//            self?.viewModel.onRefresh()
//            self?.calendarTableView.reloadData()
//
//        }

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
        return events?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventTableViewCell", for: indexPath) as! EventTableViewCell

        guard let newViewModel = events?[indexPath.row] else { return cell }
//
//        let day = Date.dayFormatter.string(from: Date.init(millis: newViewModel.event.startTime))
//
//        let month = Date.monthFormatter.string(from: Date.init(millis: newViewModel.event.startTime))
//
//        let year = Date.yearFormatter.string(from: Date.init(millis: newViewModel.event.startTime))
//
//        let intDay = Int(day) ?? 0
//        let intMonth = Int(month) ?? 0
//        let intYear = Int(year) ?? 0
//
//        eventTime == JKDay(year: intYear, month: intMonth, day: intDay)!
//
//        if intDay == selectDay.day && intMonth == selectDay.month && intYear == selectDay.year {

            cell.setup(vm: newViewModel)
//            cell.mainView.isHidden = false


//        } else {
//
//            cell.mainView.isHidden = true
//        }

        return cell
    }

//    func onTappedDate(_ time: Int64) -> Event {



//        _ = viewModel.eventViewModels.value.filter({ _ in
//            date >= selectDay.date &&
//                date <= selectDay.date
//        }) let date = Date.init(millis: time)
//        if date >= selectDay.date && date <= selectDay.date {

//            return []

//        }
//            return nil
//    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

}


extension TabCalendarViewController: JKCalendarDelegate {

    func calendar(_ calendar: JKCalendar, didTouch day: JKDay) {
        selectDay = day
        calendar.focusWeek = day < calendar.month ? 0: day > calendar.month ? calendar.month.weeksCount - 1: day.weekOfMonth - 1
        let theDay = Date.intDateFormatter.string(from: self.selectDay.date)
        events = viewModel.createSelectedData(in: viewModel.eventViewModels.value, selectedDate: theDay)
        calendar.reloadData()
        self.calendarTableView.reloadData()
    }


    func heightOfFooterView(in claendar: JKCalendar) -> CGFloat {
        return 10
    }

    func viewOfFooter(in calendar: JKCalendar) -> UIView? {
        let view = UIView()
        let line = UIView(frame: CGRect(x: 8, y: 9, width: calendar.frame.width - 16, height: 1))
        line.backgroundColor = UIColor.lightGray
        view.addSubview(line)
        return view
    }
}

extension TabCalendarViewController: JKCalendarDataSource {

    func calendar(_ calendar: JKCalendar, marksWith month: JKMonth) -> [JKCalendarMark]? {

//        let firstMarkDay: JKDay = eventTime


        var marks: [JKCalendarMark] = []

        if selectDay == month{
            marks.append(JKCalendarMark(type: .hollowCircle,
                                        day: selectDay,
                                        color: markColor))
        }

        if eventTime == month{
            marks.append(JKCalendarMark(type: .dot,
                                        day: eventTime,
                                        color: markColor))
        }
//        if secondMarkDay == month{
//            marks.append(JKCalendarMark(type: .hollowCircle,
//                                        day: secondMarkDay,
//                                        color: markColor))
//        }
            return marks

        }



    func calendar(_ calendar: JKCalendar, continuousMarksWith month: JKMonth) -> [JKCalendarContinuousMark]? {
        let startDay: JKDay = JKDay(year: 2021, month: 3, day: 17)!
        let endDay: JKDay = JKDay(year: 2021, month: 3, day: 18)!

        return [JKCalendarContinuousMark(type: .dot,
                                         start: startDay,
                                         end: endDay,
                                         color: markColor)]
    }

}


extension TabCalendarViewController: RefreshDelegate {

    func refresherDidRefresh(_ refresher: Refresher) {
        print("refresherDidRefresh")
    }
}
