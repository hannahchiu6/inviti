//
//  CalendarViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import JKCalendar

class CalendarVMController {

    let eventViewModels = Box([EventViewModel]())

//    let selectedViewModels = Box([EventViewModel]())

    var refreshView: (() -> Void)?

    var scrollToTop: (() -> Void)?

    func fetchData() {
        
        EventManager.shared.fetchEvents { [weak self] result in

            switch result {

            case .success(let events):

                self?.setEvents(events)

            case .failure(let error):

                print("fetchData.failure: \(error)")
            }
        }
    }


    func onRefresh() {
        // maybe do something
        self.refreshView?()
    }

    func onScrollToTop() {

        self.scrollToTop?()
    }

    func createSelectedData(in viewModels: [EventViewModel], selectedDate: String) -> [EventViewModel] {
        let oldViewModel = eventViewModels.value
        var newViewModels = [EventViewModel]()
        newViewModels = oldViewModel.filter({$0.event.date == Int(selectedDate)})
        return newViewModels
    }

    func createMarksData() -> [JKDay] {
        let viewModel = eventViewModels.value
        let marksDates = viewModel.map({
            Date.init(millis: $0.event.startTime)
        })

        let JDay = marksDates.map({
            JKDay(date: $0)
        })
        return JDay
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

    func onTap(withIndex index: Int) {
        eventViewModels.value[index].onTap()
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
}
