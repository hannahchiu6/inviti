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
import JGProgressHUD


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

    var eventDatas: [Event] = []

    let markColor = UIColor(red: 1, green: 0.3647, blue: 0, alpha: 1.0)

    var selectDay: JKDay = JKDay(date: Date())

    let viewModel = CalendarViewModel()
//    let viewModel = EventViewModel()

    var endTime = [String]()

    var startTime: [Date] = []

    var options: [OptionsData] = [] {
        didSet {

            self.options.sort(by: <)
//            buttonLogic()
            calendarTableView.reloadData()
        }
    }

    private var subject = String() {
        didSet {

            calendarTableView.reloadData()
        }
    }

    private var location = String() 

    @IBOutlet weak var calendarTableView: JKCalendarTableView!

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        calendarTableView.nativeDelegate = self
        calendarTableView.calendar.delegate = self
        calendarTableView.calendar.dataSource = self

        calendarTableView.calendar.focusWeek = selectDay.weekOfMonth - 1

        viewModel.refreshView = { [weak self] () in
            DispatchQueue.main.async {
                self?.calendarTableView.reloadData()
            }
        }

        viewModel.eventViewModels.bind { [weak self] events in
            self?.calendarTableView.reloadData()
            self?.viewModel.onRefresh()
        }
//
//        viewModel.scrollToTop = { [weak self] () in
//
//            self?.calendarTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        }
//
        viewModel.fetchData()


        setupRefresher()

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
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleBackButtonClick(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }

}

extension CTableViewController: JKCalendarDelegate {

    func calendar(_ calendar: JKCalendar, didTouch day: JKDay) {
        selectDay = day
        calendar.focusWeek = day < calendar.month ? 0: day > calendar.month ? calendar.month.weeksCount - 1: day.weekOfMonth - 1
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

        let firstMarkDay: JKDay = JKDay(year: 2021, month: 5, day: 9)!
        let secondMarkDay: JKDay = JKDay(year: 2021, month: 5, day: 20)!

        var marks: [JKCalendarMark] = []

        if selectDay == month{
            marks.append(JKCalendarMark(type: .circle,
                                        day: selectDay,
                                        color: markColor))
        }
        if firstMarkDay == month{
            marks.append(JKCalendarMark(type: .underline,
                                        day: firstMarkDay,
                                        color: markColor))
        }
        if secondMarkDay == month{
            marks.append(JKCalendarMark(type: .hollowCircle,
                                        day: secondMarkDay,
                                        color: markColor))
        }
        return marks
    }

    func calendar(_ calendar: JKCalendar, continuousMarksWith month: JKMonth) -> [JKCalendarContinuousMark]?{
        let startDay: JKDay = JKDay(year: 2021, month: 3, day: 17)!
        let endDay: JKDay = JKDay(year: 2021, month: 3, day: 18)!

        return [JKCalendarContinuousMark(type: .dot,
                                         start: startDay,
                                         end: endDay,
                                         color: markColor)]
    }

}

extension CTableViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.eventViewModels.value.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CTableViewCell", for: indexPath) as! CTableViewCell

        if viewModel.eventViewModels.value.isEmpty {

        }
//        if indexPath.row != 0 && indexPath.row != 24 {
//            let hour = indexPath.row
//            cell.timeLabel.text = (hour < 10 ? "0": "") + String(hour) + ":00"
//        } else {
//            cell.timeLabel.text = ""
//        }
//
//        if selectDay.date < Date() {
//            cell.bookingButton.isHidden = true
//        }
//        if indexPath.row.count > viewModel.eventViewModels.value.count -> nil
//        button. hidden
//        mapping
//
//        判斷空值的預設
//
//        func 判斷事件順序過去

        let newViewModel = viewModel.eventViewModels.value[indexPath.row]

        let endDates = getEventTime(newViewModel.event.endTime)

        let startDates = getEventTime(newViewModel.event.startTime)

//
//        let eventViewModel = viewModel.eventViewModels.value[indexPath.row]
//
//        let bookingData = firebaseBookingData
//                            .filter({$0.bookingTime.room == self.room})
//                            .filter({$0.bookingTime.date == time})
//                            .filter({$0.bookingTime.hour.contains(hour)})
//
//
//        var endDate = Date(timeIntervalSince1970: TimeInterval(eventViewModel.event.endTime))
//
//        let A = viewModel.eventViewModels.value({
//
//            $0 >= selectDay.date  &&
//            $0 <= selectDay.date
//
//        })


//
//        if let cell = cell as? CTableViewCell {
//            cell.setup(viewModel: eventViewModel)
//        }

        cell.layoutIfNeeded()

//        guard let eventCell = cell as? CTableViewCell else {
//            return cell
//        }
//
//        let cellViewModel = viewModel.eventViewModels.value
//        let event = cellViewModel[0].event
//
//        eventCell.layoutCell(with: event)
//

        let hour = indexPath.row

        let time = OptionTime(year: selectDay.year, month: selectDay.month, day: selectDay.day)


//
//        cell.bookingButton.addTarget(self, action: #selector(addBooking(sender:)), for: .touchUpInside)
//
//        if options.filter({$0.date == time}).filter({$0.hour.contains(hour)}).filter({$0.subject == self.subject}).isEmpty == false {
//
//            cell.userBookingSetup(hour: hour)
//            return cell
//        }

        return cell

    }



    private func setupItemTitle(name: String) {

        self.navigationItem.title = name + "時間"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }




    func getEventTime(_ time: Int64) -> [Event] {

        let date = Date.init(millis: time)

        _ = viewModel.eventViewModels.value.filter({_ in
            date >= selectDay.date &&
                date <= selectDay.date
        })
        return []
    }

}

extension CTableViewController {

    @objc func addBooking(sender: UIButton) {

        let bookingDate = OptionTime(
            year: selectDay.year,
            month: selectDay.month,
            day: selectDay.day)
        let hour = sender.tag

        guard let sameDateIndex = options.firstIndex(
            where: {$0.date == bookingDate && $0.subject == self.subject}) else {
            options.append(OptionsData(date: bookingDate, hour: [hour], subject: subject, location: location))
            return
        }

        guard let hourIndex = options[sameDateIndex].hour.firstIndex(where: {$0 == hour}) else {

            options[sameDateIndex].hour.append(hour)
            return
        }

        if options[sameDateIndex].hour.count == 1 {

            options.remove(at: sameDateIndex)
        } else {

            options[sameDateIndex].hour.remove(at: hourIndex)
        }
    }
}

extension CTableViewController: RefreshDelegate {

    func refresherDidRefresh(_ refresher: Refresher) {
        print("refresherDidRefresh")
    }
}
