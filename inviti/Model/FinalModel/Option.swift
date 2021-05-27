//
//  Option.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit
import FirebaseFirestoreSwift
import Foundation

struct Option: Codable{
    var id: String
//    @DocumentID var id: String?
    var startTime: Int64
    var endTime: Int64
//    var optionTime: OptionTime?
//    let duration: Int?


    enum CodingKeys: String, CodingKey {
//        case selectedOptions
        case id
//        case optionTime
//        case duration
        case startTime
        case endTime
    }

    init(startTime: Int, endTime: Int, optionTime: OptionTime, duration: Int) {
        self.startTime = 0
        self.endTime = 0
        self.id = "id"
//        self.optionTime = OptionTime(year: 2021, month: 10, day: 10)
//        self.duration = 0

    }

    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "startTime": startTime,
            "endTime": endTime,
//            "duration": duration as Any,
//            "optionTime": optionTime as Any

        ]
    }

    func startTimeToDate() -> Date {

        return Date.init(millis: startTime)
    }

    func endTimeToDate() -> Date {

        return Date.init(millis: endTime)
    }

    func startTimeToTime() -> String {

        return  Date.timeFormatter.string(from: Date.init(millis: startTime))

    }

    func endTimeToTime() -> String {

        return  Date.timeFormatter.string(from: Date.init(millis: endTime))

    }
}
