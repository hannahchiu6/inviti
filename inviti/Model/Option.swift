//
//  Option.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit
import FirebaseFirestoreSwift
import Foundation

struct Option: Codable {
    var id: String
    var startTime: Int64
    var endTime: Int64
    var optionTime: OptionTime?
    var duration: Int
    var selectedOptions: [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case selectedOptions
        case id
        case optionTime
        case duration
        case startTime
        case endTime
    }
    
    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "startTime": startTime,
            "endTime": endTime,
            "duration": duration,
            "optionTime": optionTime?.toDict as Any,
            "selectedOptions": selectedOptions as Any
            
        ]
    }

    func makeStartTimeToString() -> String {
        
        return  Date.timeFormatter.string(from: Date.init(millis: startTime))
        
    }
    
    func makeEndTimeToString() -> String {
        
        return  Date.timeFormatter.string(from: Date.init(millis: endTime))
        
    }
}
