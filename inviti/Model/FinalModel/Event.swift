//
//  Event.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit

struct Event: Codable {
    var id: String
    let owner: SimpleUser
    let startTime: Int64
    let endTime: Int64
    let subject: String
//    let notes: String
//    let participants: String
//    let location: String

    enum CodingKeys: String, CodingKey {
        case id, owner, startTime, endTime, subject
//        case notes, participants, location
    }

    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "owner": owner as Any,
            "startTime": startTime as Any,
            "endTime": endTime as Any,
            "subject": subject as Any,
//            "notes": notes as Any,
//            "participants": participants as Any,
//            "location": location as Any
        ]
    }
}
