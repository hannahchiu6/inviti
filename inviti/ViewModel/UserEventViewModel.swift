//
//  UserEventViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase

class UserEventViewModel {

    var eventViewModels = Box([EventViewModel]())

    var ownerID = UserDefaults.standard.value(forKey: "uid")

    var event: Event = Event(id: "", startTime: 0, endTime: 0, date: 0, subject: "", location: "")

    func onInfoChanged(text subject: String, location: String, date: Int) {
        self.event.subject = subject
        self.event.location = location
        self.event.date = date
    }

    func onTimeChanged(_ startTime: Int64, endTime: Int64) {
        self.event.startTime = startTime
        self.event.endTime = endTime
    }

    var refreshView: (() -> Void)?

    var scrollToTop: (() -> Void)?

    var onEventCreated: (() -> Void)?

    func convertEventsToViewModels(from events: [Event]) -> [EventViewModel] {
        let viewModels = [EventViewModel]()

        var newVMs = viewModels.sorted(by: { $0.startTime  > $1.startTime })

        for event in events {
            let viewModel = EventViewModel(model: event)
            newVMs.append(viewModel)
        }
        return viewModels
    }

    func setEvents(_ events: [Event]) {
        eventViewModels.value = convertEventsToViewModels(from: events)
    }

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

    func onRefresh() {

        self.refreshView?()
    }

    func onScrollToTop() {

        self.scrollToTop?()
    }


    func create() {

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
