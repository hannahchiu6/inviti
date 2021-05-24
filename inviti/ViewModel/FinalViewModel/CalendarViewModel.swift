//
//  CalendarViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation

class CalendarViewModel {

    let eventViewModels = Box([EventViewModel]())

    var refreshView: (() -> Void)?

    var scrollToTop: (() -> Void)?

    func fetchData() {

        EventManager.shared.fetchEvents { [weak self] result in

            switch result {

            case .success(let events):

                self?.setEvents(events)
                print("--------- CalendarViewModel-----------")
                print("\(events[0].startTime)")
                print("--------- CalendarViewModel & returnTimeToDateTyp & year -----------")
                print("\(Date.yearFormatter.string(from: Date.init(millis: events[0].startTime)))")
                print("--------- CalendarViewModel & Function & monthFormatter : StartTime -----------")
                print("\(Date.monthFormatter.string(from: Date.init(millis: events[0].startTime))))")
                print("--------- CalendarViewModel & Function & dayFormatter : StartTime -----------")
                print("\(Date.dayFormatter.string(from: Date.init(millis: events[0].startTime))))")

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
