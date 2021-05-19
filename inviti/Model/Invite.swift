//
//  Invite.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit

struct Invite: Codable {
    let id: String
    let sender: String
    let receiver: String
    let createdTime: Int64
    let email: String
    let meeting: Meeting


    enum CodingKeys: String, CodingKey {
        case id, sender, receiver, email
        case createdTime, meeting
    }

    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "owner": sender as Any,
            "receiver": receiver as Any,
            "createdTime": createdTime as Any,
            "email": email as Any,
            "meeting": meeting as Any,
        ]
    }
}
