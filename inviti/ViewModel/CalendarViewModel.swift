//
//  CalendarViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
// swiftLint disable: trailing_closure

import Foundation
import JKCalendar

class CalendarViewModel {
    
    let eventViewModels = Box([EventViewModel]())
    
    var refreshView: (() -> Void)?
    
    var scrollToTop: (() -> Void)?
    
    var onEventCreated: (() -> Void)?
    
    var onDead: (() -> Void)?
    
    func fetchData() {
        
        EventManager.shared.fetchSubEvents { [weak self] result in
            
            switch result {
            
            case .success(let events):
                
                self?.setEvents(events)
                
            case .failure(let error):
                
                print("fetchData.failure: \(error)")
            }
        }
    }
    
    func convertEventsToViewModels(from events: [Event]) -> [EventViewModel] {
        var viewModels = [EventViewModel]()
        for event in events {
            let viewModel = EventViewModel(model: event)
            viewModels.append(viewModel)
        }
        return viewModels
    }
    
    func setEvents(_ events: [Event]) {
        eventViewModels.value = convertEventsToViewModels(from: events)
    }
    
    func onRefresh() {
        // maybe do something
        self.refreshView?()
    }
    
    func onScrollToTop() {
        
        self.scrollToTop?()
    }
    
    func createEvent(with event: inout Event) {
        
        EventManager.shared.createEvent(event: &event) { result in
            
            switch result {
            
            case .success:
                
                print("onTapCreate event, success")
                self.onEventCreated?()
                
            case .failure(let error):
                
                print("createMeeting.failure: \(error)")
            }
        }
    }
    
    func createSelectedData(in viewModels: [EventViewModel], selectedDate: String) -> [EventViewModel] {
        var newViewModels = [EventViewModel]()
        newViewModels = viewModels.filter({ $0.event.date == Int(selectedDate) })
        
        return newViewModels
    }
    
    func createIntDateData(in viewModels: [EventViewModel]) -> [Int?] {
        
        let theTime = viewModels.map({
                                        Int(Date.intDateFormatter.string(from: Date(millis: $0.event.startTime)))})
        
        return theTime
    }
    
    func createMarksData() -> [JKDay] {
        
        let viewModel = eventViewModels.value
        let marksDates = viewModel.map({
            Date.init(millis: $0.event.startTime)
        })
        
        let JDays = marksDates.map({
            JKDay(date: $0)
        })
        return JDays
    }
    func createTimeData(in viewModels: [EventViewModel]) -> [JKDay] {
        let eventDates = viewModels.map({
            Date.init(millis: $0.event.startTime)
        })
        
        let JDays = eventDates.map({
            JKDay(date: $0)
        })
        return JDays
    }
    
    func onEmptyTap(_ eventID: String) {
        EventManager.shared.deleteEvent(eventID: eventID) { [weak self] result in
            
            switch result {
            
            case .success:
                
                self?.onDead?()
                
            case .failure(let error):
                
                print("fetchData.failure: \(error)")
            }
        }
    }
}
