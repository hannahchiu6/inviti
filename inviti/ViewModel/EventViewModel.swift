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
    
    var location: String {
        get {
            return event.location
        }
    }
    var startTime: Int64 {
        get {
            return event.startTime
        }
    }
    
    var endTime: Int64 {
        get {
            return event.endTime
        }
    }
    var date: Int {
        get {
            return event.date
        }
    }
}
