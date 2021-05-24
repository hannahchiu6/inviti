//
//  EventViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import UIKit

class EventViewModel {

    var event: Event

    var onDead: (() -> Void)?

    init(model event: Event) {
        self.event = event
    }

    var id: String {
        get {
            return event.id
        }
    }

    var subject: String {
        get {
            return event.subject
        }
    }

    var owner: SimpleUser {
        get {
            return event.owner
        }
    }

    var startTime: String {
        get {
            return Date.dateFormatter.string(from: Date.init(millis: event.startTime))
        }
    }

    var endTime: String {
        get {
            return Date.dateFormatter.string(from: Date.init(millis: event.endTime))
        }
    }

    func onTap() {
        EventManager.shared.deleteEvent(event: event) { [weak self] result in

            switch result {

            case .success(let eventID):

                print(eventID)
                self?.onDead?()

            case .failure(let error):

                print("eventDeleted.failure: \(error)")
            }
        }
    }
}
