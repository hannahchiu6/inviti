//
//  Event.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit
import Firebase
import Foundation

struct Event: Equatable, Codable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.startTime == rhs.startTime && lhs.endTime == rhs.endTime
    }
    
    var id: String
    var startTime: Int64
    var endTime: Int64
    var date: Int
    var subject: String
    var location: String
    
    enum CodingKeys: String, CodingKey {
        case id, startTime, endTime, subject, date, location
    }

    var toDict: [String: Any] {
        return [
            "id": id,
            "startTime": startTime,
            "endTime": endTime,
            "subject": subject,
            "date": date,
            "location": location as Any
        ]
    }
    
    func makeStartTimeToTimeString() -> String {
        
        return  Date.timeFormatter.string(from: Date.init(millis: startTime))
        
    }
    
    func makeEndTimeToTimeString() -> String {
        
        return  Date.timeFormatter.string(from: Date.init(millis: endTime))
        
    }
}
