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
//    @DocumentID var id: String?
    var startTime: Int64
    var endTime: Int64
    var optionTime: OptionTime?
    var duration: Int
    var selectedOptions: [SelectedOption]?


    enum CodingKeys: String, CodingKey {

        case selectedOptions
        case id
        case optionTime
        case duration
        case startTime
        case endTime
    }

//    init(startTime: Int, endTime: Int, optionTime: OptionTime, duration: Int) {
//        self.startTime = 0
//        self.endTime = 0
//        self.id = "id"
//        self.optionTime = OptionTime(year: 2021, month: 10, day: 10)
//        self.duration = 60
//        self.selectedOptions = [SelectedOption(isSelected: false, selectedUser: nil)]
//
//    }

    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "startTime": startTime,
            "endTime": endTime,
            "duration": duration as Any,
            "optionTime": optionTime?.toDict as Any,
            "selectedOptions": selectedOptions as Any

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

    func startTimeToHour() -> String {

        return  Date.hourFormatter.string(from: Date.init(millis: startTime))

    }

    func endTimeToHour() -> String {

        return  Date.hourFormatter.string(from: Date.init(millis: endTime))

    }


    func endTimeToTime() -> String {

        return  Date.timeFormatter.string(from: Date.init(millis: endTime))

    }
}
