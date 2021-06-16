//
//  NotificationViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase

class NotificationViewModel {
    
    var notification: Notification
    
    var onDead: (() -> Void)?
    
    init(model notification: Notification) {
        self.notification = notification
    }
    
    var id: String {
        get {
            return notification.id
        }
    }
    
    var meetingID: String? {
        get {
            return notification.meetingID
        }
    }
    
    var subject: String? {
        get {
            return notification.subject
        }
    }
    
    var participantID: String? {
        get {
            return notification.participantID
        }
    }
    
    var eventID: String? {
        get {
            return notification.eventID
        }
    }
    
    var type: String? {
        get {
            return notification.type
        }
    }
    
    var createdTime: Int64 {
        get {
            
            return notification.createdTime
        }
    }
    
    var  ownerName: String? {
        get {
            return notification.ownerName
        }
    }
    
    func onTap() {
        NotificationManager.shared.deleteNotification(notification: notification) { [weak self] result in
            
            switch result {
            
            case .success(let notificationID):
                
                print(notificationID)
                self?.onDead?()
                
            case .failure(let error):
                
                print("publishMeeting.failure: \(error)")
            }
        }
    }
    
}
