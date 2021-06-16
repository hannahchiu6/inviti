//
//  Notification.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit
import FirebaseFirestoreSwift

struct Notification: Codable {
    var id: String
    var meetingID: String?
    var eventID: String?
    var participantID: String?
    var createdTime: Int64
    var type: String?
    var ownerName: String?
    var subject: String?
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case meetingID, eventID, participantID, image
        case type, id, createdTime, ownerName, subject
    }
    
    var toDict: [String: Any] {
        return [
            "id": id,
            "meetingID": meetingID as Any,
            "eventID": eventID as Any,
            "participantID": participantID as Any,
            "subject": subject as Any,
            "type": type as Any,
            "createdTime": createdTime,
            "ownerName": ownerName as Any,
            "image": image as Any
        ]
    }
    
    func makeTimeToDateString() -> String {
        
        return  Date.pointFormatter.string(from: Date.init(millis: createdTime))
        
    }
}

enum TypeName: String {
    
    case vote = "participantVoted"
    
    case invite = "inviteReceived"
    
    case deadline = "eventToDeadline"
    
    case calendar = "calendarEventAdded"
}
