//
//  Meeting.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

struct Meeting: Codable {
    var id: String
//    var owner: String
    var owner: SimpleUser
    var ownerAppleID: String
    var createdTime: Int64
    var subject: String?
    var location: String?
    var notes: String?
    var image: String?
    var options: [Option]?
    var singleMeeting: Bool
    var hiddenMeeting: Bool
    var deadlineMeeting: Bool
    var participants: [String]?
    var numOfParticipants: Int?
    var deadlineTag: Int?
//    @Document var id: String?
    //    let askInfo: AskInfo
    //    var invitation: [String]?

    enum CodingKeys: String, CodingKey {
        case id, owner, subject, notes, createdTime
        case options, ownerAppleID
//        case startTime, endTime
//        case askInfo
        case participants, location, numOfParticipants
        case hiddenMeeting, singleMeeting, image
        case deadlineTag, deadlineMeeting
    }

    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "owner": owner.toDict,
            "ownerAppleID": ownerAppleID,
            "createdTime": createdTime,
//            "startTime": startTime as Any,
//            "endTime": endTime as Any,
            "subject": subject as Any,
            "image": image as Any,
            "notes": notes as Any,
//            "invitation": invitation as Any,
            "participants": participants as Any,
            "location": location as Any,
//            "duration": duration as Any,
            "options": options as Any,
            "singleMeeting": singleMeeting as Any,
            "deadlineMeeting": deadlineMeeting as Any,
            "hiddenMeeting": hiddenMeeting as Any,
            "numOfParticipants": numOfParticipants as Any,
            "deadlineTag": deadlineTag as Any
//            "askInfo": askInfo.toDict as Any

        ]
    }
}
