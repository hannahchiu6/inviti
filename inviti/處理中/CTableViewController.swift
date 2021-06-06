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

protocol CTableViewDelegate: AnyObject {
    func optionDidSelect(getData: Bool)
}

class CTableViewController: UIViewController {

    weak var delegate: CTableViewDelegate?

    var selectDay: JKDay = JKDay(date: Date())

    var duration = 0

    var options: [Option] = []

    var viewModel = CalendarViewModel()

    var selectedOptionViewModel = SelectOptionViewModel()

    var optionViewModels: [OptionViewModel]?

    var eventViewModels: [EventViewModel]?

    var onOptionCreated: (() -> Void )?

    var meetingInfo: Meeting?

    var meetingID: String = ""

    var dataIsEmpty: Bool = true

    @IBOutlet weak var calendarTableView: JKCalendarTableView!

//    var hasOptionData = true

    var onUpdate: ((_ meetingID: String) -> Void)?


    @IBOutlet weak var confirmBtn: UIButton!

    @IBAction func backButton(_ sender: Any) {

        self.navigationController?.popViewController(animated: true)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        calendarTableView.nativeDelegate = self
        calendarTableView.calendar.delegate = self
        calendarTableView.calendar.dataSource = self

        calendarTableView.calendar.focusWeek = selectDay.weekOfMonth - 1

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        viewModel.eventViewModels.bind { [weak self] events in

            self?.viewModel.onRefresh()
            self?.calendarTableView.reloadData()
            self?.calendarTableView.calendar.reloadData()

        }

        selectedOptionViewModel.refreshView = { [weak self] () in
            DispatchQueue.main.async {
                self?.calendarTableView.reloadData()
//                self!.calendarTableView.calendar.reloadData()
            }
        }

        selectedOptionViewModel.optionViewModels.bind { [weak self] options in

            self?.selectedOptionViewModel.onRefresh()
            self?.calendarTableView.reloadData()
        }

        if dataIsEmpty {

        } else {

            selectedOptionViewModel.fetchData(meetingID: meetingID)

        }

        viewModel.fetchData()

        NotificationCenter.default.addObserver(self, selector: #selector(optionAdded), name: UITextField.textDidChangeNotification, object: nil)

    }

    @objc func optionAdded() {

        let data = selectedOptionViewModel.optionViewModels.value

        if data.isEmpty {

            self.confirmBtn.isEnabled = false
            self.confirmBtn.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)

        } else {

            self.confirmBtn.isEnabled = true
            self.confirmBtn.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00)
        }
    }

//    private func updateButton() {
//
//        switch options.count {
//
//        case 0:
//            nextBtnView.alpha = 0.7
//            nextBtnView.isEnabled = false
//            nextBtnView.tintColor = UIColor.lightGray
//
//        default:
//            nextBtnView.alpha = 1
//            nextBtnView.isEnabled = true
//        }
//    }

//    private var cTableViewController: UIViewController
//
//       override func show(_ vc: UIViewController, sender: Any?) {
//            cTableViewController.removeFromParent()
//            cTableViewController = vc
//            add(vc)
//       }

//    func setupRefresher() {
//
//        calendarTableView.refresh.header.addRefreshClosure { [weak self] in
//            self?.viewModel.fetchData()
//            self?.calendarTableView.refresh.header.endRefreshing()
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func handleBackButtonClick(_ sender: Any) {

        navigationController?.popViewController(animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "backToFirstSegue" {
            let vc = segue.destination as! CreateFirstViewController
            self.delegate = vc
        }
    }

}

extension CTableViewController: JKCalendarDelegate {

    func calendar(_ calendar: JKCalendar, didTouch day: JKDay) {

        selectDay = day
        
        calendar.focusWeek = day < calendar.month ? 0: day > calendar.month ? calendar.month.weeksCount - 1: day.weekOfMonth - 1

        let theDay = Date.intDateFormatter.string(from: self.selectDay.date)

        selectedOptionViewModel.fetchData(meetingID: meetingID)

        eventViewModels = viewModel.createSelectedData(in: viewModel.eventViewModels.value, selectedDate: theDay)

        calendar.reloadData()

//        calendarTableView.reloadData()
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

        let bookingDate = OptionTime(year: selectDay.year, month: selectDay.month, day: selectDay.day)

        let selectedOptions = selectedOptionViewModel.markSelectedDay(in: selectedOptionViewModel.optionViewModels.value, selectedDate: bookingDate)

        let today = JKDay(date: Date())

        let marksDay = viewModel.createMarksData()

        let markColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00)

        let todayColor = UIColor(red: 0.78, green: 0.49, blue: 0.35, alpha: 1.00)


        if selectDay == month {
            marks.append(JKCalendarMark(type: .circle,
                                        day: selectDay,
                                        color: markColor))
        }


        for day in selectedOptions {

            if day == month {
                marks.append(JKCalendarMark(type: .circle,
                                            day: day,
                                            color: markColor))
            }
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

        cell.setup(index: indexPath.row)

        cell.meetingID = meetingID

        cell.selectDay = selectDay.date

        cell.createOptionViewModel.option = selectedOptionViewModel.option

        cell.selectedOptionViewModel = self.selectedOptionViewModel

        if selectDay.date < Date() {

            cell.bookingButton.isHidden = true

        } else {

            cell.bookingButton.isHidden = false

        }

        let bookingDate = OptionTime(
            year: selectDay.year,
            month: selectDay.month,
            day: selectDay.day)

        let hour = indexPath.row

        let selectedDays = viewModel.createTimeData(in: eventViewModels ?? [])

        if selectedDays.contains(selectDay) {

            let eventHours = eventViewModels!.map({ Int(Date.hourFormatter.string(from: Date(millis: $0.event.startTime)))})
                if eventHours.contains(hour) {

                    cell.hasEventStatus()

                } else {

                    cell.setupEmptyStatus()
                }
        }

        let selectedOptionDays = selectedOptionViewModel.createDateData(in: selectedOptionViewModel.optionViewModels.value )

        cell.bookingButton.setImage(UIImage(systemName: "minus"), for: .selected)
        cell.bookingButton.setImage(UIImage(systemName: "plus"), for: .normal)

        if selectedOptionDays.contains(bookingDate) {

                let newVM = selectedOptionViewModel.createSelectedOption(in: selectedOptionViewModel.optionViewModels.value, selectedDate: bookingDate)

                let optionHours =
                    selectedOptionViewModel.createTimeData(in: newVM)

                if optionHours.contains(hour) {

                    cell.bookingButton.isSelected = true

                    cell.bookingButton.tag = indexPath.row

                    cell.meetingTimeSelected()

                } else {

                    cell.bookingButton.isSelected = false

                    cell.meetingTimeDeselected()
                }
            }  else {

                cell.bookingButton.isSelected = false


            }
        return cell

    }

    private func setupItemTitle(name: String) {

        self.navigationItem.title = name + "時間"
    }

//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CTableViewCell", for: indexPath) as! CTableViewCell
//
////        cell.eventView.isHidden = true
//    }

}

extension CTableViewController {

    func getOptionArray(sender: UIButton) {

        let bookingDate = OptionTime(
            year: selectDay.year,
            month: selectDay.month,
            day: selectDay.day)
        
//        let hour = sender.tag

        let updateDate = selectedOptionViewModel.option

        guard let sameDateIndex =

         options.firstIndex(
            where: { $0.optionTime == bookingDate }) else {
            options.append(Option(id: "", startTime: Int64(Int((
                                                        updateDate.startTime)))
                                  , endTime: Int64(Int((
                                                        updateDate.endTime))), optionTime: bookingDate, duration: 60))
            return }

        guard (optionViewModels?.map({ Int(Date.hourFormatter.string(from: Date(millis: $0.option.startTime)))})) != nil
        else { return }
    }
}
