//
//  Option.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit

struct Option: Codable {
    let id: String
    let meetingID: String
    let startTime: Int64
    let endTime: Int64
    let selectedOptions: [OptionSelected]


    enum CodingKeys: String, CodingKey {
        case id, meetingID, selectedOptions
        case startTime, endTime
    }

    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "meetingID": meetingID as Any,
            "startTime": startTime as Any,
            "endTime": endTime as Any,
            "selectedOptions": selectedOptions as Any

        ]
    }
}
