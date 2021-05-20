//
//  Meeting.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit
import Firebase

struct Meeting: Codable {
    var id: String
    var owner: String
    var createdTime: Int64
    var subject: String
    var location: String?
    var notes: String?
    var image: String?
//    let options: Option
    let singleMeeting: Bool
    let hiddenMeeting: Bool
//    let askInfo: AskInfo
    let participants: [String]
    let numOfParticipants: Int
    //    let startTime: Int64
    //    let endTime: Int64
    //    let duration: Int64


    enum CodingKeys: String, CodingKey {
        case id, owner, subject, notes, createdTime
//        case startTime, endTime, duration, askInfo, options
        case participants, location, numOfParticipants
        case hiddenMeeting, singleMeeting, image
    }

    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "owner": owner as Any,
            "createdTime": createdTime as Any,
//            "startTime": startTime as Any,
//            "endTime": endTime as Any,
            "subject": subject as Any,
            "image": image as Any,
            "notes": notes as Any,
            "participants": participants as Any,
            "location": location as Any,
//            "duration": duration as Any,
//            "options": options as Any,
            "singleMeeting": singleMeeting as Any,
            "hiddenMeeting": hiddenMeeting as Any,
            "numOfParticipants": numOfParticipants as Any,
//            "askInfo": askInfo as Any

        ]
    }
}
