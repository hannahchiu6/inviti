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
    var numberForSearch: String
//    var owner: SimpleUser
    var ownerAppleID: String
    var createdTime: Int64
    var subject: String?
    var location: String?
    var notes: String?
    var image: String?
    var options: [Option]?
    var singleMeeting: Bool = false
    var hiddenMeeting: Bool = false
    var deadlineMeeting: Bool = false
    var participants: [String]?
    var numOfParticipants: Int?
    var deadlineTag: Int?
    var isClosed: Bool = false
//    var finalOption: Option?
    var finalOption: FinalOption? // startTime
//    @Document var id: String?
    //    let askInfo: AskInfo
    //    var invitation: [String]?

    enum CodingKeys: String, CodingKey {
        case id, subject, notes, createdTime, numberForSearch
        case options, ownerAppleID, isClosed
        case participants, location, numOfParticipants
        case hiddenMeeting, singleMeeting, image
        case deadlineTag, deadlineMeeting, finalOption
    }

    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "numberForSearch": numberForSearch,
            "ownerAppleID": ownerAppleID,
            "createdTime": createdTime,
            "finalOption": finalOption?.toDict as Any,
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
            "deadlineTag": deadlineTag as Any,
//            "askInfo": askInfo.toDict as Any
            "isClosed": isClosed

        ]
    }
}
