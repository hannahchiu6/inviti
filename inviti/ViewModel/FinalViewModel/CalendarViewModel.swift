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

        EventManager.shared.fetchEvent { [weak self] result in

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
