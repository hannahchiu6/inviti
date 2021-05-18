//
//  CalendarViewController.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {

    let eventSubjects = ["停電大作戰", "防疫你我一起來", "在家乖乖寫扣吧"]
    let eventNotes = ["趕緊充手機充好充滿", "口罩戴好戴滿", "記得要洗手一分鐘"]
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendar: FSCalendar!

    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()

        eventTableView.delegate = self
        eventTableView.dataSource = self

        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)

        eventTableView.register(nib, forCellReuseIdentifier: "eventTableViewCell")

        if UIDevice.current.model.hasPrefix("iPad") {
            self.calendarHeightConstraint.constant = 400
        }

        self.calendar.select(Date())
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calendarHeightConstraint.constant = 400
        }

        self.calendar.select(Date())

        self.view.addGestureRecognizer(self.scopeGesture)
        self.eventTableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.calendar.scope = .month

        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"

        self.view.addGestureRecognizer(self.scopeGesture)
        self.calendar.scope = .month

        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"

    }

    func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        let rightButton = UIBarButtonItem(image: UIImage(named: "NotificationBell.png"), style: .plain, target: nil, action: nil)
        rightButton.tintColor = UIColor(red: 1, green: 0.3647, blue: 0, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = rightButton
    }

    // MARK:- UIGestureRecognizerDelegate

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.eventTableView.contentOffset.y <= -self.eventTableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }

    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
}

extension CalendarViewController: UITableViewDelegate {
}

extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventNotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCell(withIdentifier: "eventTableViewCell", for: indexPath) as! EventTableViewCell

//        cell.eventSubject = cellData[indexPath.row].0
//            cell.bgImageView.image = cellData[indexPath.row].1
        cell.eventSubject.text = eventSubjects[indexPath.row]
        cell.eventNotes.text = eventNotes[indexPath.row]

        return cell
    }
}

extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate {
}

