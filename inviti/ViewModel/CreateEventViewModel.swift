//
//  CreateEventViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase

class CreateEventViewModel {

    var eventViewModels = Box([EventViewModel]())

    var event: Event = Event(id: "", owner: SimpleUser(id: "5gWVjg7xTHElu9p6Jkl1", email: "moon2021@gmail.com", image: "https://lh3.googleusercontent.com/proxy/u2icusi6aMz0vKbu8L5F3tEEadtx3DVcJD_Ya_lubYz6MH4A9a6KL0CFvAeeaDWJ9sIr44RQz8Qy3zJE72Cq1rPUZeZr4FLxXGRkLdNBs2-VxhpIVSY6JnPnjYzLp0Q"), startTime: 0, endTime: 0, date: 0, subject: "", location: "")

    func onInfoChanged(text subject: String, location: String, date: Int) {
        self.event.subject = subject
        self.event.location = location
        self.event.date = date
    }

    func onTimeChanged(_ startTime: Int64, endTime: Int64) {
        self.event.startTime = startTime
        self.event.endTime = endTime
    }

    func onOwnerChanged(_ owner: SimpleUser) {
        self.event.owner = owner
    }

    var refreshView: (() -> Void)?

    var scrollToTop: (() -> Void)?

    var onEventCreated: (() -> Void)?

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

        self.refreshView?()
    }

    func onScrollToTop() {

        self.scrollToTop?()
    }


    func create(with user: SimpleUser? = nil) {

        if let user = user {
            event.owner = user
        }

        create(with: &event)
    }

    func create(with event: inout Event) {
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
}
