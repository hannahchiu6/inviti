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
        
        if !dataIsEmpty {
            
            selectedOptionViewModel.fetchData(meetingID: meetingID)
            
        }
        
        viewModel.fetchData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(optionAdded), name: UITextField.textDidChangeNotification, object: nil)
        
    }
    
    @objc func optionAdded() {
        
        let data = selectedOptionViewModel.optionViewModels.value
        
        if data.isEmpty {
            
            self.confirmBtn.isEnabled = false
            self.confirmBtn.backgroundColor = UIColor.midGray
            
        } else {
            
            self.confirmBtn.isEnabled = true
            self.confirmBtn.backgroundColor = UIColor.mainOrange
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func handleBackButtonClick(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "backToFirstSegue" {
            
            guard let vc = segue.destination as? CreateFirstViewController else { return }
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

        let today = JKDay(date: Date())

        let marksDay = viewModel.createMarksData()

        let selectedOptions = selectedOptionViewModel.markOptionsDay(in: selectedOptionViewModel.optionViewModels.value)

        let markColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00)
        let todayColor = UIColor(red: 0.9765, green: 0.3608, blue: 0.251, alpha: 1.0)
        let optionColor = UIColor(red: 1, green: 0.8353, blue: 0.7882, alpha: 1.0)

        if selectDay == month {
            marks.append(JKCalendarMark(type: .circle, day: selectDay, color: markColor))
        }

        for day in selectedOptions where day == month {

            marks.append(JKCalendarMark(type: .hollowCircle, day: day, color: optionColor))
        }

        if today == month {
            marks.append(JKCalendarMark(type: .circle, day: today, color: optionColor))
        }


        for i in marksDay where i == month {

            marks.append(JKCalendarMark(type: .dot, day: i, color: todayColor))

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CTableViewCell", for: indexPath)

        guard let ctCell = cell as? CTableViewCell else { return cell }
        
        ctCell.setup(index: indexPath.row)
        
        ctCell.meetingID = meetingID
        
        ctCell.selectDay = selectDay.date
        
        ctCell.createOptionViewModel.option = selectedOptionViewModel.option
        
        ctCell.selectedOptionViewModel = self.selectedOptionViewModel
        
        if selectDay.date < Date() {
            
            ctCell.bookingButton.isHidden = true
            
        } else {
            
            ctCell.bookingButton.isHidden = false
            
        }
        
        let bookingDate = OptionTime(
            year: selectDay.year,
            month: selectDay.month,
            day: selectDay.day)
        
        let hour = indexPath.row
        
        let selectedDays = viewModel.createTimeData(in: eventViewModels ?? [])
        
        if selectedDays.contains(selectDay) {
            
            let eventHours = eventViewModels!.map({ Int(Date.hourFormatter.string(from: Date(millis: $0.event.startTime))) })
            if eventHours.contains(hour) {
                
                ctCell.hasEventStatus()
                
            } else {
                
                ctCell.setupEmptyStatus()
            }
        }
        
        let selectedOptionDays = selectedOptionViewModel.createDateData(in: selectedOptionViewModel.optionViewModels.value )
        
        ctCell.bookingButton.setImage(UIImage(systemName: "minus"), for: .selected)
        ctCell.bookingButton.setImage(UIImage(systemName: "plus"), for: .normal)
        
        if selectedOptionDays.contains(bookingDate) {
            
            let newVM = selectedOptionViewModel.createSelectedOption(in: selectedOptionViewModel.optionViewModels.value, selectedDate: bookingDate)
            
            let optionHours =
                selectedOptionViewModel.createTimeData(in: newVM)
            
            if optionHours.contains(hour) {
                
                ctCell.bookingButton.isSelected = true
                
                ctCell.bookingButton.tag = indexPath.row
                
                ctCell.selectedMeetingTime()
                
            } else {
                
                ctCell.bookingButton.isSelected = false
                
                ctCell.deselectedMeetingTime()
            }
            
        } else {
            
            ctCell.bookingButton.isSelected = false
        }
        return ctCell
    }
    
    private func setupItemTitle(name: String) {
        
        self.navigationItem.title = name + "時間"
    }
}

extension CTableViewController {
    
    func getOptionArray(sender: UIButton) {
        
        let bookingDate = OptionTime(
            year: selectDay.year,
            month: selectDay.month,
            day: selectDay.day)
        
        let updateDate = selectedOptionViewModel.option
        
        guard options.firstIndex( where: { $0.optionTime == bookingDate }) != nil
        
        else {
            
            options.append(Option(id: "", startTime: Int64(Int((updateDate.startTime))), endTime: Int64(Int((updateDate.endTime))), optionTime: bookingDate, duration: 60))
            
            return
            
        }
        
        guard (optionViewModels?.map({ Int(Date.hourFormatter.string(from: Date(millis: $0.option.startTime))) })) != nil
        
        else { return }
    }
}
