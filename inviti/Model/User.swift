//
//  User.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

struct User: Codable {
    
    var id: String
    var email: String?
    var name: String?
    var image: String?
    let phone: String?
    let address: String?
    let isCalendarSynced: Bool = false
    let calendarType: String?
    let numOfMeetings: Int?
    var events: [Event]?
    var notification: [Notification]?
    var numberForSearch: String
    
    
    enum CodingKeys: String, CodingKey {
        case id, email, name
        case image, phone, address, numOfMeetings
        case isCalendarSynced, calendarType
        case events, notification, numberForSearch
    }
    
    var toDict: [String: Any] {
        return [
            "id": id,
            "email": email as Any,
            "name": name as Any,
            "events": events as Any,
            "image": image as Any,
            "numOfMeetings": numOfMeetings as Any,
            "phone": phone as Any,
            "address": address as Any,
            "calendarType": calendarType as Any,
            "isCalendarSynced": isCalendarSynced,
            "notification": notification as Any,
            "numberForSearch": numberForSearch
            
        ]
    }
}
