//
//  CalendarViewController.swift
//  inviti
//
//  Created by Hannah.C on 22.05.21.
//

import UIKit
import JKCalendar

class CalendarViewController: UIViewController {

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

//    @IBOutlet weak var textField: UITextField!
//    @IBOutlet weak var button: UIButton! {
//
//        didSet {
//
//            buttonLogic()
//        }
//    }
    var markColor: UIColor {

        guard let color = UIColor.myColorEnd else {

            return UIColor.lightGray
        }

        return color
    }
    var selectDay: JKDay = JKDay(date: Date())

    var bookingTimeDatas: [BookingTimeAndRoom] = [] {
        didSet {

            self.bookingTimeDatas.sort(by: <)
//            buttonLogic()
            calendarTableView.reloadData()
        }
    }

    private var room = String() {
        didSet {

            calendarTableView.reloadData()
        }
    }

    private var price = String()
    private var firebaseBookingData: [UserEventData] = [] {

        didSet {

            calendarTableView.reloadData()
        }
    }

    @IBOutlet weak var calendarTableView: JKCalendarTableView!


    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    var storeData: StoreData?

    let storeManager: StoreManager = StoreManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        calendarTableView.calendar.delegate = self
        calendarTableView.calendar.dataSource = self
        calendarTableView.calendar.focusWeek = selectDay.weekOfMonth - 1

//        getFirebaseBookingData()
        calendarTableView.rowHeight = 60
//        button.setupButtonModelPlayBand()
        calendarTableView.isHidden = true
        setupPickerView()
    }

//    private func getFirebaseBookingData() {
//
//        guard let data = storeData else { return }
//
//        PBProgressHUD.addLoadingView(animated: true)
//
//        storeManager.getStoreBookingDatas(storeName: data.name) { [weak self] (result) in
//
//            PBProgressHUD.dismissLoadingView(animated: true)
//
//            switch result {
//
//            case .success(let data):
//                self?.calendarTableView.isHidden = false
//                self?.firebaseBookingData = data
//
//            case .failure(let error):
//                self?.addErrorTypeAlertMessage(error: error)
//            }
//        }
//    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        guard let nextVC = segue.destination as? ConfirmViewController else {return}
//        nextVC.loadViewIfNeeded()
//
//        nextVC.bookingTimeDatas = self.bookingTimeDatas
//        nextVC.storeData = self.storeData
//        nextVC.bookingDatasChange = { [weak self] changeDatas in
//            self?.bookingTimeDatas = changeDatas
//        }
//    }
//    private func buttonLogic() {
//
//        switch bookingTimeDatas.count {
//        case 0:
//            button.alpha = 0.7
//            button.isEnabled = false
//            button.setTitle(ButtonText.buttonIsNotEnabled.returnString(), for: .normal)
//        default:
//            button.alpha = 1
//            button.isEnabled = true
//            var hourCount = 0
//            for hours in bookingTimeDatas {
//
//                hourCount += hours.hour.count
//            }
//            button.setTitle(ButtonText.buttonIsEnabled(hourCount).returnString(), for: .normal)
//        }
//    }

    private func setupPickerView() {

        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
//        textField.inputView = picker
        guard let room = storeData?.rooms[0] else {
            return
        }
        setupItemTitle(name: room.name)
//        textField.text = room.name
        self.room = room.name
        self.price = room.price
    }
}

extension CalendarViewController: JKCalendarDelegate {

    func calendar(_ calendar: JKCalendar, didTouch day: JKDay) {
        selectDay = day
        calendar.focusWeek = day < calendar.month
            ? 0
            : day > calendar.month ? calendar.month.weeksCount - 1: day.weekOfMonth - 1
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

extension CalendarViewController: JKCalendarDataSource {

    func calendar(_ calendar: JKCalendar, marksWith month: JKMonth) -> [JKCalendarMark]? {

        let firstMarkDay: JKDay = JKDay(year: 2018, month: 1, day: 9)!
        let secondMarkDay: JKDay = JKDay(year: 2018, month: 1, day: 20)!

        var marks: [JKCalendarMark] = []
        if selectDay == month {
            marks.append(JKCalendarMark(type: .circle,
                                        day: selectDay,
                                        color: markColor))
        }
        if firstMarkDay == month {
            marks.append(JKCalendarMark(type: .underline,
                                        day: firstMarkDay,
                                        color: markColor))
        }
        if secondMarkDay == month {
            marks.append(JKCalendarMark(type: .hollowCircle,
                                        day: secondMarkDay,
                                        color: markColor))
        }
        return marks
    }

    func calendar(_ calendar: JKCalendar, continuousMarksWith month: JKMonth) -> [JKCalendarContinuousMark]? {
        let startDay: JKDay = JKDay(year: 2018, month: 1, day: 17)!
        let endDay: JKDay = JKDay(year: 2018, month: 1, day: 18)!

        return [JKCalendarContinuousMark(type: .dot,
                                         start: startDay,
                                         end: endDay,
                                         color: markColor)]
    }

}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

//        return storeData?.getStoreOpenHours() ?? 0
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: "CalendarTableViewCell"),
            for: indexPath) as? CalendarTableViewCell else { return UITableViewCell() }

        if selectDay.date < Date() {
            cell.bookingButton.isHidden = true
        }

        let hour = indexPath.row + (Int(storeData?.openTime ?? "0") ?? 0)
        let time = BookingDate(year: selectDay.year, month: selectDay.month, day: selectDay.day)

        let bookingData = firebaseBookingData
                            .filter({$0.bookingTime.date == time})
                            .filter({$0.bookingTime.hour.contains(hour)})
                            .filter({$0.bookingTime.room == self.room})

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
        cell.bookingButton.addTarget(self, action: #selector(addBooking(sender:)), for: .touchUpInside)

        if bookingTimeDatas.filter({$0.date == time}).filter({$0.hour.contains(hour)}).filter({$0.room == self.room}).isEmpty == false {

            cell.userBookingSetup(hour: hour)
            return cell
        }

        cell.setupCell(hour: hour)
        return cell
    }

    private func setupItemTitle(name: String) {

        self.navigationItem.title = name + "時間"
    }
}

extension CalendarViewController {

    @objc func addBooking(sender: UIButton) {

        let bookingDate = BookingDate(
            year: selectDay.year,
            month: selectDay.month,
            day: selectDay.day)
        let hour = sender.tag

        guard let sameDateIndex = bookingTimeDatas.firstIndex(
            where: {$0.date == bookingDate && $0.room == self.room}) else {
                bookingTimeDatas.append(BookingTimeAndRoom(date: bookingDate, hour: [hour], room: room, price: price))
            return
        }

        guard let hourIndex = bookingTimeDatas[sameDateIndex].hour.firstIndex(where: {$0 == hour}) else {

            bookingTimeDatas[sameDateIndex].hour.append(hour)
            return
        }

        if bookingTimeDatas[sameDateIndex].hour.count == 1 {

            bookingTimeDatas.remove(at: sameDateIndex)
        } else {

            bookingTimeDatas[sameDateIndex].hour.remove(at: hourIndex)
        }
    }
}

extension CalendarViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {

        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        guard let rooms = storeData?.rooms else {return 0}

        return rooms.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        guard let name = storeData?.rooms[row].name else {return String()}
        return name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        guard let room = storeData?.rooms[row] else {return}
//        textField.text = room.name
        setupItemTitle(name: room.name)
        self.room = room.name
        self.price = room.price
    }
}
