//
//  File.swift
//  inviti
//
//  Created by Hannah.C on 24.05.21.
//

import UIKit
import JKCalendar
import Firebase
import FirebaseFirestoreSwift
import EasyRefresher


class CTableViewController: UIViewController {

    private enum ButtonText {

        case buttonIsEnabled(Int)
        case buttonIsNotEnabled

        func returnString() -> String {

            switch self {
//            case .buttonIsEnabled(let count):
            case .buttonIsEnabled:
                return "Busy hours"
//                return "現有預定 \(count) 小時"
            case .buttonIsNotEnabled:

                return "尚未預訂"
            }
        }
    }

    var selectDay: JKDay = JKDay(date: Date()){
        didSet {
            self.calendarTableView.reloadData()

        }
    }

    var duration = 0

    var options: [Option] = [] {
        didSet {

//            self.options.sort(by: <)
            updateButton()
            calendarTableView.reloadData()
        }
    }

    var viewModel = CalendarVMController() {
        didSet {
            calendarTableView.calendar.reloadData()
        }
    }

    var optionViewModel = SelectVMController()

    var eventViewModels: [EventViewModel]?

    var meetingInfo: Meeting?{
        didSet {
            dataIsEmpty = !dataIsEmpty
        }
    }

    var dataIsEmpty: Bool = true

    @IBOutlet weak var calendarTableView: JKCalendarTableView!

    @IBOutlet weak var nextBtnView: UIButton!

    @IBOutlet weak var goNextPage: UIButton!

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        calendarTableView.nativeDelegate = self
        calendarTableView.calendar.delegate = self
        calendarTableView.calendar.dataSource = self

        calendarTableView.calendar.focusWeek = selectDay.weekOfMonth - 1

        viewModel.eventViewModels.bind { [weak self] events in

            self?.viewModel.onRefresh()
            self?.calendarTableView.reloadData()

        }

        viewModel.refreshView = { [weak self] () in
            DispatchQueue.main.async {
                self?.calendarTableView.reloadData()
            }
        }

        optionViewModel.optionViewModels.bind { [weak self] events in

            self?.optionViewModel.onRefresh()
            self?.calendarTableView.reloadData()

        }

        if dataIsEmpty {

        } else {

            optionViewModel.fetchData(meeting: meetingInfo!)

        }

        viewModel.fetchData()

        setupRefresher()

    }

    private func updateButton() {

        switch options.count {

        case 0:
            nextBtnView.alpha = 0.7
            nextBtnView.isEnabled = false
            nextBtnView.tintColor = UIColor.lightGray

        default:
            nextBtnView.alpha = 1
            nextBtnView.isEnabled = true
        }
    }

    func setupRefresher() {
        self.calendarTableView.refresh.header = RefreshHeader(delegate: self)

        calendarTableView.refresh.header.addRefreshClosure { [weak self] in
            self?.viewModel.fetchData()
            self?.calendarTableView.refresh.header.endRefreshing()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func handleBackButtonClick(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }

}

extension CTableViewController: JKCalendarDelegate {

    func calendar(_ calendar: JKCalendar, didTouch day: JKDay) {
        selectDay = day
        calendar.focusWeek = day < calendar.month ? 0: day > calendar.month ? calendar.month.weeksCount - 1: day.weekOfMonth - 1

        let theDay = Date.intDateFormatter.string(from: self.selectDay.date)

        eventViewModels = viewModel.createSelectedData(in: viewModel.eventViewModels.value, selectedDate: theDay)

        calendar.reloadData()

        calendarTableView.reloadData()
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

extension CTableViewController: JKCalendarDataSource {

    func calendar(_ calendar: JKCalendar, marksWith month: JKMonth) -> [JKCalendarMark]? {

        var marks: [JKCalendarMark] = []

        let today = JKDay(date: Date())

        var marksDay = viewModel.createMarksData()

        let markColor = UIColor(red: 1, green: 0.3647, blue: 0, alpha: 1.0)

        let todayColor = UIColor(red: 252/255, green: 77/255, blue: 38/255, alpha: 1.0)


        if selectDay == month {
            marks.append(JKCalendarMark(type: .circle,
                                        day: selectDay,
                                        color: markColor))
        }

        if today == month {
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


extension CTableViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CTableViewCell", for: indexPath) as! CTableViewCell


        let hour = indexPath.row

        cell.setup(index: hour)

        let selectedDays = viewModel.createTimeData(in: eventViewModels ?? [])

        if selectedDays.contains(selectDay) {

            let hours = eventViewModels!.map({ Int(Date.hourFormatter.string(from: Date(millis: $0.event.startTime)))})

            if hours.contains(hour) {

                cell.hasEventStatus()

            } else {

                cell.setupEmptyStatus()
            }

        } else {

            cell.setupEmptyStatus()

        }

        if selectDay.date < Date() - 1 {

            cell.bookingButton.isHidden = true

        } else {
            
            cell.bookingButton.isHidden = false
        }

        cell.delegate = self

//        cell.delegate?.tapped(index: indexPath.row)

//        cell.bookingButton.addTarget(self, action: #selector(addOption(sender:)), for: .touchUpInside)

        return cell

    }

    private func setupItemTitle(name: String) {

        self.navigationItem.title = name + "時間"
    }

}

//extension CTableViewController {
//
//    @objc func addOption(sender: UIButton) {



//
//        guard let dateIndex = options.firstIndex(
//                where: { JKDay(date: $0.date) == bookingDate }) else {
//            options.append(Option(meetingID: "", startTime: startTime, endTime: endTime, date: Int(bookingDate.dateString()), selectedOptions: []))
//
//            return
//        }
//
//        guard let hourIndex = options[sameDateIndex].hour.firstIndex(where: {$0 == hour}) else {
//
//            options[sameDateIndex].hour.append(hour)
//            return
//        }
//
//        if options[sameDateIndex].hour.count == 1 {
//
//            options.remove(at: sameDateIndex)
//        } else {
//
//            options[sameDateIndex].hour.remove(at: hourIndex)
//        }
//    }


extension CTableViewController: RefreshDelegate {

    func refresherDidRefresh(_ refresher: Refresher) {
        print("refresherDidRefresh")
    }
}

extension CTableViewController: CTableViewCellDelegate {

    func tapped(_ sender: CTableViewCell, index: Int) {

        let storyboard: UIStoryboard = UIStoryboard(name: "Create", bundle: nil)
        let editVC = storyboard.instantiateViewController(identifier: "CreateFirstPageVC")
           guard let edit = editVC as? CreateFirstPageVC else { return }

//        guard self.tableView.indexPath(for: sender) != nil else { return }

//        edit.options = sender.options

        let bookingDate = OptionTime(
            year: selectDay.year,
            month: selectDay.month,
            day: selectDay.day)

        let hour = index

        let startTime = (hour < 10 ? "0": "") + String(hour) + ":00"

        let endHour = hour + duration
        let endTime = (endHour  < 10 ? "0": "") + String(endHour ) + ":00"

    }

}
