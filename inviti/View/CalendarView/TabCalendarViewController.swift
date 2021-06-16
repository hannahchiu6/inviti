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
    
    var viewModel = CalendarViewModel()
    
    var eventViewModels: [EventViewModel]?
    
    var eventIDs: [String]?
    
    @IBOutlet weak var calendarTableView: JKCalendarTableView!
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchData()
        calendarTableView.reloadData()
    }
    
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
        
        self.tabBarController?.tabBar.isHidden = false
        
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
        
        let theDay = Date.intDateFormatter.string(from: self.selectDay.date)
        
        let selectedDays = viewModel.createIntDateData(in: viewModel.eventViewModels.value)
        
        if selectedDays.contains(Int(theDay)) {
            
            let theDay = Date.intDateFormatter.string(from: self.selectDay.date)
            
            let eventModel = viewModel.createSelectedData(in: viewModel.eventViewModels.value, selectedDate: theDay)
            
            return eventModel.count
            
        } else {
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventTableViewCell", for: indexPath) as! EventTableViewCell
        
        let theDay = Date.intDateFormatter.string(from: self.selectDay.date)
        
        let selectedDays = viewModel.createTimeData(in: viewModel.eventViewModels.value)
        
        if selectedDays.contains(selectDay) {
            
            let eventModel = viewModel.createSelectedData(in: viewModel.eventViewModels.value, selectedDate: theDay)
            
            cell.setup(vm: eventModel[indexPath.row])
            
            self.eventIDs = eventModel.map({ $0.id })
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, boolValue in
            guard let eventIDs = self.eventIDs else { return }
            
            self.viewModel.onEmptyTap(eventIDs[indexPath.row])
            
            self.viewModel.onDead = { [weak self] () in
                
                self?.viewModel.fetchData()
            }
        }
        
        contextItem.backgroundColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.00)
        
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
        return swipeActions
    }
    
}

extension TabCalendarViewController: JKCalendarDelegate {
    
    func calendar(_ calendar: JKCalendar, didTouch day: JKDay) {
        
        selectDay = day
        
        calendar.focusWeek = day < calendar.month ? 0: day > calendar.month ? calendar.month.weeksCount - 1: day.weekOfMonth - 1
        
        let theDay = Date.intDateFormatter.string(from: self.selectDay.date)
        
        eventViewModels = viewModel.createSelectedData(in: viewModel.eventViewModels.value, selectedDate: theDay)
        
        self.calendarTableView.reloadData()
        
        calendar.reloadData()
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
        
        let markColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00)
        
        let todayColor = UIColor(red: 0.78, green: 0.49, blue: 0.35, alpha: 1.00)
        
        let optionColor = UIColor(red: 1, green: 0.8353, blue: 0.7882, alpha: 1.0)
        
        
        var marks: [JKCalendarMark] = []
        
        let today = JKDay(date: Date())
        
        let marksDay = viewModel.createMarksData()
        
        if selectDay == month {
            marks.append(JKCalendarMark(type: .circle,
                                        day: selectDay,
                                        color: markColor))
        }
        
        if today == month {
            marks.append(JKCalendarMark(type: .circle,
                                        day: today,
                                        color: optionColor))
        }
        
        
        for i in marksDay where i == month {
            
            marks.append(JKCalendarMark(type: .dot,
                                        day: i,
                                        color: todayColor))
            
        }
        return marks
    }
}


extension TabCalendarViewController: RefreshDelegate {
    
    func refresherDidRefresh(_ refresher: Refresher) {
        print("refresherDidRefresh")
    }
}
