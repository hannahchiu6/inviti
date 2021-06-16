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
    
    var ownerID = UserDefaults.standard.value(forKey: "uid")
    
    var event: Event = Event(id: "", startTime: 0, endTime: 0, date: 0, subject: "", location: "")
    
    func onInfoChanged(meeting: Meeting) {
        
        if let subject = meeting.subject,
           let location = meeting.location {
            self.event.subject = subject
            self.event.location = location
        }
        //        self.event.date = date
    }
    
    func onTimeChanged(_ startTime: Int64, endTime: Int64, option: OptionTime) {
        self.event.startTime = startTime
        self.event.endTime = endTime
        self.event.date = option.makeDateToInt()
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
    
    func createForParticipants(peopleID: [String]) {
        EventManager.shared.createParticipantsEvent(peopleID: peopleID, event: &event) { result in
            
            switch result {
            
            case .success:
                
                print("create event for everyone, success!")
                
                INProgressHUD.showSuccess(text: "分享成功")
                
            case .failure(let error):
                
                INProgressHUD.showFailure(text: "請稍後再試")
                
                print("create event failure: \(error)")
            }
        }
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
                
                print("create event failure: \(error)")
            }
        }
    }
}
