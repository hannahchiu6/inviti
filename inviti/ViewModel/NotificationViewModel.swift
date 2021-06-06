//
//  NotificationViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//
//  swiftlint:disable force_unwrapping inclusive_language closure_end_indentation

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

//    var typeName: UIColor {
//        get {
//            switch article.category {
//            case "IU":
//                return UIColor.deepPurple
//            case "Beauty":
//                return UIColor.indigo
//            case "SchoolLife":
//                return UIColor.orange
//            case "Test":
//                return UIColor.red
//            default:
//                return UIColor.green
//            }
//        }
//    }

}
