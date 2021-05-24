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

    let markColor = UIColor(red: 1, green: 0.3647, blue: 0, alpha: 1.0)

    var selectDay: JKDay = JKDay(date: Date())

    let viewModel = CalendarViewModel()

//    var eventData: Event?

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

    // 原本就有的 calendar event?????
//    private var firebaseBookingData: [UserSelectedData] = [
//        UserSelectedData(id: "003", selectedOption: OptionsData(date: OptionTime(year: 2021, month: 05, day: 28), hour: [14, 15, 16], subject: "看電視", location: "溫暖的家"), status: "status不知填什麼", userInfo: SimpleUser(id: "5gWVjg7xTHElu9p6Jkl1", email: "moon2021@gmail.com", image: "https://lh3.googleusercontent.com/proxy/u2icusi6aMz0vKbu8L5F3tEEadtx3DVcJD_Ya_lubYz6MH4A9a6KL0CFvAeeaDWJ9sIr44RQz8Qy3zJE72Cq1rPUZeZr4FLxXGRkLdNBs2-VxhpIVSY6JnPnjYzLp0Q"), userUID: "0981234", meetingID: "e1B7EjfC1v9vfzcVyPf5"),
//        UserSelectedData(id: "005", selectedOption: OptionsData(date: OptionTime(year: 2021, month: 05, day: 27), hour: [08, 12, 16], subject: "畫畫", location: "你家就是我家"), status: "status不知填什麼", userInfo: SimpleUser(id: "5gWVjg7xTHElu9p6Jkl1", email: "moon2021@gmail.com", image: "https://lh3.googleusercontent.com/proxy/u2icusi6aMz0vKbu8L5F3tEEadtx3DVcJD_Ya_lubYz6MH4A9a6KL0CFvAeeaDWJ9sIr44RQz8Qy3zJE72Cq1rPUZeZr4FLxXGRkLdNBs2-VxhpIVSY6JnPnjYzLp0Q"), userUID: "0981234", meetingID: "e1B7EjfC1v9vfzcVyPf5"),
//    ] {
//
//        didSet {
//
//            calendarTableView.reloadData()
//        }
//    }

    private var eventData: [Event?] = [Event(id: "007", owner: SimpleUser(id: "5gWVjg7xTHElu9p6Jkl1", email: "moon2021@gmail.com", image: "https://lh3.googleusercontent.com/proxy/u2icusi6aMz0vKbu8L5F3tEEadtx3DVcJD_Ya_lubYz6MH4A9a6KL0CFvAeeaDWJ9sIr44RQz8Qy3zJE72Cq1rPUZeZr4FLxXGRkLdNBs2-VxhpIVSY6JnPnjYzLp0Q"), startTime: 1621834831, endTime: 1621837831, subject: "吃壽司"), Event(id: "008", owner: SimpleUser(id: "5gWVjg7xTHElu9p6Jkl1", email: "moon2021@gmail.com", image: "https://lh3.googleusercontent.com/proxy/u2icusi6aMz0vKbu8L5F3tEEadtx3DVcJD_Ya_lubYz6MH4A9a6KL0CFvAeeaDWJ9sIr44RQz8Qy3zJE72Cq1rPUZeZr4FLxXGRkLdNBs2-VxhpIVSY6JnPnjYzLp0Q"), startTime: 1621839831, endTime: 1621841831, subject: "期末考")]{
            didSet {

                calendarTableView.reloadData()
            }
        }


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
//            self?.tableView.reloadData()
            self?.viewModel.onRefresh()
        }

        viewModel.scrollToTop = { [weak self] () in

            self?.calendarTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }

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
        return 24
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CTableViewCell", for: indexPath) as! CTableViewCell

        if indexPath.row != 0 && indexPath.row != 24 {
            let hour = indexPath.row
            cell.timeLabel.text = (hour < 10 ? "0": "") + String(hour) + ":00"
        } else {
            cell.timeLabel.text = ""
        }

        if selectDay.date < Date() {
            cell.bookingButton.isHidden = true
        }


        let hour = indexPath.row

        let time = OptionTime(year: selectDay.year, month: selectDay.month, day: selectDay.day)

//        let eventData = firebaseBookingData
//            .filter({$0.selectedOption.date == time})
//            .filter({$0.selectedOption.hour.contains(hour)})
//            .filter({$0.selectedOption.subject == self.subject})
//
//        let eventYear = eventData.first(where: {time .dateString()
//
//        }
//            .
//                        selectedOption.date == time})
//            .filter({$0.selectedOption.hour.contains(hour)})
//            .filter({$0.selectedOption.subject == self.subject})

//        if eventData.isEmpty {
//
//            cell.fireBaseBookingSetup(text: "喝杯咖啡", hour: hour)
//
//            } else {
//
//                if ((cell.viewModel?.subject.contains(subject)) != nil) {
//
////                        FirebaseManager.shared.storeName.contains(storeData?.name ?? "") {
//
////                    cell.fireBaseBookingSetup(text: "\(eventData[0].userInfo.id)預定此時間", hour: hour)
//            }
//
//            return cell
//        }

        cell.bookingButton.addTarget(self, action: #selector(addBooking(sender:)), for: .touchUpInside)

        if options.filter({$0.date == time}).filter({$0.hour.contains(hour)}).filter({$0.subject == self.subject}).isEmpty == false {

            cell.userBookingSetup(hour: hour)
            return cell
        }
//        cell.setup(viewModel: viewModel.eventViewModels.value[0])

//        cell.setupCell(hour: hour)
        // add new
//        guard let eventViewCell = cell as? CTableViewCell else {
//            return cell
//        }
//
//        let eventCount = self.viewModel.eventViewModels.value.count
//
//        let cellViewModel = self.viewModel.eventViewModels.value[eventCount]
//
//        cellViewModel.onDead = { [weak self] () in
//            print("onDead")
//
//            self?.viewModel.fetchData()
//        }
//
//        eventViewCell.setup(viewModel: cellViewModel)
//
        return cell

    }


    private func setupItemTitle(name: String) {

        self.navigationItem.title = name + "時間"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
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
