////
////  CalendarViewController.swift
////  inviti
////
////  Created by Hannah.C on 22.05.21.
////
//
//import UIKit
//import JKCalendar
//import Firebase
//import FirebaseFirestoreSwift
//import EasyRefresher
//import JGProgressHUD
//
//class CalendarViewController: UIViewController {
//
//    private enum ButtonText {
//// 送出確認的最下面的按鈕
//        case buttonIsEnabled(Int)
//        case buttonIsNotEnabled
//
//        func returnString() -> String {
//
//            switch self {
////            case .buttonIsEnabled(let count):
//            case .buttonIsEnabled:
//                return "Busy hours"
////                return "現有預定 \(count) 小時"
//            case .buttonIsNotEnabled:
//                return "尚未預訂"
//            }
//        }
//    }
//
////    @IBOutlet weak var textField: UITextField!
////    @IBOutlet weak var button: UIButton! {
////
////        didSet {
////
////            buttonLogic()
////        }
////    }
//
//    var markColor: UIColor {
//
//        guard let color = UIColor.myColorEnd else {
//
//            return UIColor.lightGray
//        }
//
//        return color
//    }
//    var selectDay: JKDay = JKDay(date: Date())
//
//    let viewModel = CalendarViewModel()
//
//    var eventData: Event?
//
//    var options: [OptionsData] = [] {
//        didSet {
//
//            self.options.sort(by: <)
////            buttonLogic()
//            calendarTableView.reloadData()
//        }
//    }
//
//    private var subject = String() {
//        didSet {
//
//            calendarTableView.reloadData()
//        }
//    }
//
//    private var location = String()
//
//    private var firebaseBookingData: [UserSelectedData] = [
//        UserSelectedData(id: "003", selectedOption: OptionsData(date: OptionTime(year: 2021, month: 05, day: 28), hour: [14, 15, 16], subject: "看電視", location: "溫暖的家"), status: "status不知填什麼", userInfo: SimpleUser(id: "123", email: "moon2021@gmail.com", image: "www"), userUID: "0981234", meetingID: "meetingID"),
//    ] {
//
//        didSet {
//
//            calendarTableView.reloadData()
//        }
//    }
//
//    @IBOutlet weak var calendarTableView: JKCalendarTableView!
//
//
//    @IBAction func backButton(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        calendarTableView.do_registerCellWithNib(
//            identifier: String(describing: CalendarNibCell.self),bundle: nil)
//
//
//        calendarTableView.calendar.delegate = self
//        calendarTableView.calendar.dataSource = self
//        calendarTableView.calendar.focusWeek = selectDay.weekOfMonth - 1
//
//        calendarTableView.rowHeight = 60
////        button.setupButtonModelPlayBand()
//        calendarTableView.isHidden = true
//        viewModelInit()
//    }
//
//    func viewModelInit() {
//        viewModel.refreshView = { [weak self] () in
//            DispatchQueue.main.async {
//                self?.calendarTableView.reloadData()
//            }
//        }
//
//        viewModel.eventViewModels.bind { [weak self] events in
////            self?.tableView.reloadData()
//            self?.viewModel.onRefresh()
//        }
//
//        viewModel.scrollToTop = { [weak self] () in
//
//            self?.calendarTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        }
//
//        viewModel.fetchData()
//
//        setupRefresher()
//    }
//
//    func setupRefresher() {
//        self.calendarTableView.refresh.header = RefreshHeader(delegate: self)
//
//        calendarTableView.refresh.header.addRefreshClosure { [weak self] in
//            self?.viewModel.fetchData()
//            self?.calendarTableView.refresh.header.endRefreshing()
//        }
//    }
////    private func getFirebaseBookingData() {
////
////        guard let data = storeData else { return }
////
////        PBProgressHUD.addLoadingView(animated: true)
////
////        storeManager.getStoreBookingDatas(storeName: data.name) { [weak self] (result) in
////
////            PBProgressHUD.dismissLoadingView(animated: true)
////
////            switch result {
////
////            case .success(let data):
////                self?.calendarTableView.isHidden = false
////                self?.firebaseBookingData = data
////
////            case .failure(let error):
////                self?.addErrorTypeAlertMessage(error: error)
////            }
////        }
////    }
//
////    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////
////        guard let nextVC = segue.destination as? ConfirmViewController else {return}
////        nextVC.loadViewIfNeeded()
////
////        nextVC.options = self.options
////        nextVC.storeData = self.storeData
////        nextVC.bookingDatasChange = { [weak self] changeDatas in
////            self?.options = changeDatas
////        }
////    }
////    private func buttonLogic() {
////
////        switch options.count {
////        case 0:
////            button.alpha = 0.7
////            button.isEnabled = false
////            button.setTitle(ButtonText.buttonIsNotEnabled.returnString(), for: .normal)
////        default:
////            button.alpha = 1
////            button.isEnabled = true
////            var hourCount = 0
////            for hours in options {
////
////                hourCount += hours.hour.count
////            }
////            button.setTitle(ButtonText.buttonIsEnabled(hourCount).returnString(), for: .normal)
////        }
////    }
//}
//
//extension CalendarViewController: JKCalendarDelegate {
//
//    func calendar(_ calendar: JKCalendar, didTouch day: JKDay) {
//        selectDay = day
//        calendar.focusWeek = day < calendar.month ? 0 : day > calendar.month ? calendar.month.weeksCount - 1 : day.weekOfMonth - 1
//        calendar.reloadData()
//        calendarTableView.reloadData()
//    }
//
//    func heightOfFooterView(in claendar: JKCalendar) -> CGFloat {
//        return 10
//    }
//
//    func viewOfFooter(in calendar: JKCalendar) -> UIView? {
//        let view = UIView()
//        let line = UIView(frame: CGRect(x: 8, y: 9, width: calendar.frame.width - 16, height: 1))
//        line.backgroundColor = UIColor.green
//        view.addSubview(line)
//        return view
//    }
//}
//
//extension CalendarViewController: JKCalendarDataSource {
//
//    func calendar(_ calendar: JKCalendar, marksWith month: JKMonth) -> [JKCalendarMark]? {
//
//        let firstMarkDay: JKDay = JKDay(year: 2020, month: 1, day: 9)!
//        let secondMarkDay: JKDay = JKDay(year: 2021, month: 1, day: 20)!
//
//        var marks: [JKCalendarMark] = []
//
//        if selectDay == month {
//            marks.append(JKCalendarMark(type: .circle,
//                                        day: selectDay,
//                                        color: markColor))
//        }
//        if firstMarkDay == month {
//            marks.append(JKCalendarMark(type: .underline,
//                                        day: firstMarkDay,
//                                        color: markColor))
//        }
//        if secondMarkDay == month {
//            marks.append(JKCalendarMark(type: .hollowCircle,
//                                        day: secondMarkDay,
//                                        color: markColor))
//        }
//        return marks
//    }
//
//    func calendar(_ calendar: JKCalendar, continuousMarksWith month: JKMonth) -> [JKCalendarContinuousMark]? {
//
//        let startDay: JKDay = JKDay(year: 2021, month: 2, day: 17)!
//        let endDay: JKDay = JKDay(year: 2021, month: 2, day: 18)!
//
//        return [JKCalendarContinuousMark(type: .dot,
//                                         start: startDay,
//                                         end: endDay,
//                                         color: markColor)]
//    }
//
//}
//
//extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
////        return storeData?.getStoreOpenHours() ?? 0
////        return self.viewModel.eventViewModels.value.count
//        return 24
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(
//            withIdentifier: String(describing: CalendarNibCell.self),
//            for: indexPath) as? CalendarNibCell else { return UITableViewCell() }
//
////        guard let cell = tableView.dequeueReusableCell(
////            withIdentifier: String(describing: "CalendarTableViewCell"),
////            for: indexPath) as? CalendarTableViewCell else { return UITableViewCell() }
//
//        if indexPath.row % 2 == 0 && indexPath.row != 0 && indexPath.row != 47{
//            let hour = indexPath.row / 2
//            cell.timeLabel.text = (hour < 10 ? "0": "") + String(hour) + ":00"
//        }else{
//            cell.timeLabel.text = ""
//        }
//
//        return cell
//
//
//        if selectDay.date < Date() {
//            cell.bookingButton.isHidden = true
//        }
//
//        let cellViewModel = self.viewModel.eventViewModels.value[indexPath.row]
//
////        cell.setup(viewModel: cellViewModel)
//        let hour = 1
//
//        let time = OptionTime(year: selectDay.year, month: selectDay.month, day: selectDay.day)
//
//        let bookingData = firebaseBookingData
//                            .filter({$0.selectedOption.date == time})
//                            .filter({$0.selectedOption.hour.contains(hour)})
//                            .filter({$0.selectedOption.subject == self.subject})
//
//        if bookingData.isEmpty {
//
//            cell.fireBaseBookingSetup(hour: hour)
//
//            } else {
//
//                if FirebaseManager.shared.storeName.contains(storeData?.name ?? "") {
//
//                    cell.fireBaseBookingSetup(text: "\(bookingData[0].userInfo.name)預定此時間", hour: hour)
//            }
//
//            return cell
//        }
//        cell.bookingButton.addTarget(self, action: #selector(addBooking(sender:)), for: .touchUpInside)
//
//        if options.filter({$0.date == time}).filter({$0.hour.contains(hour)}).filter({$0.subject == self.subject}).isEmpty == false {
//
//            cell.userBookingSetup(hour: hour)
//            return cell
//        }
//
//        cell.setupCell(hour: hour)
//        return cell
//    }
//
//    private func setupItemTitle(name: String) {
//
//        self.navigationItem.title = name + "時間"
//    }
//}
////
////extension CalendarViewController {
////
////    @objc func addBooking(sender: UIButton) {
////
////        let bookingDate = OptionTime(
////            year: selectDay.year,
////            month: selectDay.month,
////            day: selectDay.day)
////        let hour = sender.tag
////
////        guard let sameDateIndex = options.firstIndex(
////            where: {$0.date == bookingDate && $0.subject == self.subject}) else {
////            options.append(OptionsData(date: bookingDate, hour: [hour], subject: subject, location: location))
////            return
////        }
////
////        guard let hourIndex = options[sameDateIndex].hour.firstIndex(where: {$0 == hour}) else {
////
////            options[sameDateIndex].hour.append(hour)
////            return
////        }
////
////        if options[sameDateIndex].hour.count == 1 {
////
////            options.remove(at: sameDateIndex)
////        } else {
////
////            options[sameDateIndex].hour.remove(at: hourIndex)
////        }
////    }
////}
//
//extension CalendarViewController: RefreshDelegate {
//    func refresherDidRefresh(_ refresher: Refresher) {
//        print("refresherDidRefresh")
//    }
//}
