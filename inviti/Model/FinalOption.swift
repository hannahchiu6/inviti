//
//  FinalOption.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit
import FirebaseFirestoreSwift
import Foundation

struct FinalOption: Codable {
    var startTime: Int64
    var endTime: Int64
    var optionTime: OptionTime?
    
    enum CodingKeys: String, CodingKey {
        case optionTime
        case startTime
        case endTime
    }
    
    var toDict: [String: Any] {
        return [
            "startTime": startTime,
            "endTime": endTime,
            "optionTime": optionTime?.toDict as Any
            
        ]
    }
 
    func makeStartTimeToString() -> String {
        
        return  Date.timeFormatter.string(from: Date.init(millis: startTime))
        
    }
    
    func makeEndTimeToTimeString() -> String {
        
        return  Date.timeFormatter.string(from: Date.init(millis: endTime))
        
    }
}
