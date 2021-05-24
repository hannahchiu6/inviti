//
//  User.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
//    let id: String
    @DocumentID var id: String?
    let email: String
    let name: String
    let appleID: String
    let image: String?
    let phone: String?
    let address: String?
    let isCalendarSynced: Bool
    let calendarType: String?
    let numOfMeetings: Int?

    enum CodingKeys: String, CodingKey {
        case id, email, name, appleID
        case image, phone, address, numOfMeetings
        case isCalendarSynced, calendarType

    }

    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "email": email as Any,
            "lastName": name as Any,
            "appleID": appleID as Any,
            "image": image as Any,
            "numOfMeetings": numOfMeetings as Any,
            "phone": phone as Any,
            "address": address as Any,
            "calendarTye": calendarType as Any,
            "isCalendarSynced": isCalendarSynced as Any

        ]
    }
}
