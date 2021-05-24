//
//  EventViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import UIKit

class EventViewModel {

//    var event: Event = Event(id: "007", owner: SimpleUser(id: "5gWVjg7xTHElu9p6Jkl1", email: "moon2021@gmail.com", image: "https://lh3.googleusercontent.com/proxy/u2icusi6aMz0vKbu8L5F3tEEadtx3DVcJD_Ya_lubYz6MH4A9a6KL0CFvAeeaDWJ9sIr44RQz8Qy3zJE72Cq1rPUZeZr4FLxXGRkLdNBs2-VxhpIVSY6JnPnjYzLp0Q"), startTime: 1621843921947, endTime: 1621843931947, subject: "吃火鍋")
//
//
//    func onSubjectChanged(text subject: String) {
//        self.event.subject = subject
//    }
//
//    func onStartTimeChanged(time startTime: Int64) {
//        self.event.startTime = startTime
//    }
//
//    func onEndTimeChanged(time endTime: Int64) {
//        self.event.endTime = endTime
//    }
//
//    func onImageChanged(image image: String) {
//        self.event.owner.image = image
//    }
//
//    var onEventCreated: (() -> Void)?
////// 修改到這邊... 有點亂晚點重新來過

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

    var startTime: (String,String,String) {
        get {
//            print("----------EventView Model----------")
//            print("\(Date.dateFormatter.string(from: Date.init(millis: event.startTime)))")

            let year = Date.yearFormatter.string(from: Date.init(millis: event.startTime))
            let month = Date.monthFormatter.string(from: Date.init(millis: event.startTime))
            let day = Date.dayFormatter.string(from: Date.init(millis: event.startTime))
            return (year, month, day)


        }
    }

    var endTime: (String,String,String) {
        get {

            let year = Date.yearFormatter.string(from: Date.init(millis: event.endTime))
            let month = Date.monthFormatter.string(from: Date.init(millis: event.endTime))
            let day = Date.dayFormatter.string(from: Date.init(millis: event.endTime))
            return (year, month, day)
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
