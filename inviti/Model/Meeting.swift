//
//  Meeting.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit

struct Meeting: Codable {
    let id: String
    let owner: String
    let createdTime: Int64
//    let startTime: Int64
//    let endTime: Int64
    let subject: String
    let location: String
    let notes: String
//    let duration: Int64
    let options: Option
    let singleMeeting: Bool
    let hiddenMeeting: Bool
    let askInfo: AskInfo
    let participants: String
    let numOfParticipants: Int


    enum CodingKeys: String, CodingKey {
        case id, owner, subject, notes, createdTime
//        case startTime, endTime, duration
        case participants, location, numOfParticipants, askInfo
        case hiddenMeeting, singleMeeting, options
    }

    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "owner": owner as Any,
            "createdTime": createdTime as Any,
//            "startTime": startTime as Any,
//            "endTime": endTime as Any,
            "subject": subject as Any,
            "notes": notes as Any,
            "participants": participants as Any,
            "location": location as Any,
//            "duration": duration as Any,
            "options": options as Any,
            "singleMeeting": singleMeeting as Any,
            "hiddenMeeting": hiddenMeeting as Any,
            "numOfParticipants": numOfParticipants as Any,
            "askInfo": askInfo as Any

        ]
    }
}
