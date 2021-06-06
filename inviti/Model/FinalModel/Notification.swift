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

//    [
//        "participantVoted",
//        "eventCreated",
//        "eventToDeadline",
//        "invitesAccepted",
//        "calendarEventAdded"
//    ]

    enum CodingKeys: String, CodingKey {
        case meetingID, eventID, participantID
        case type, id, createdTime
    }

    var toDict: [String: Any] {
        return [
            "id": id,
            "meetingID": meetingID as Any,
            "eventID": eventID as Any,
            "participantID": participantID as Any,
            "type": type as Any,
            "createdTime": createdTime,
        ]
    }
}

enum TypeName: String {

    case vote = "participantVoted"

    case invite = "inviteReceived"

    case deadline = "eventToDeadline"

    case calendar = "calendarEventAdded"
}
