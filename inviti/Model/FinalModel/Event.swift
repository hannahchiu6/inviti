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
        return lhs.startTime == lhs.startTime && lhs.endTime  == lhs.endTime
    }

//    static func < (lhs: Event, rhs: Event) -> Bool {
//
//        return lhs.startTime == lhs.startTime ? lhs.endTime == lhs.endTime :
//            lhs.endTime < rhs.endTime : lhs.startTime < rhs.startTime
//
//    }

    var id: String
    var owner: SimpleUser
    var startTime: Int64
    var endTime: Int64
    var subject: String
//    let notes: String
//    let participants: String
//    let location: String

    enum CodingKeys: String, CodingKey {
        case id, owner, startTime, endTime, subject
//        case notes, participants, location
    }

//        self.subject = subject
//        self.id = id
//        self.startTime = startTime.dateValue()
//        self.endTime = endTime.dateValue()
//        self.owner = user
//
//
    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "owner": owner as Any,
            "startTime": startTime as Any,
            "endTime": endTime as Any,
            "subject": subject as Any,
//            "notes": notes as Any,
//            "participants": participants as Any,
//            "location": location as Any
        ]
    }

    func returnTimeToDateType(time: Int64) -> Date {

        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy"
        if let newDate = dateFormat.date(from: "\(time)") {
            return newDate
        }

        return Date()

    }

    func returnDay(time: Int64) -> Int {

        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let dateTest = dateFormat.date(from: "\(time)") {

            return dateTest.day
        }
        return 0

    }

    func returnFormat(time: Int64) {

        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormat.date(from: "\(time)") {

            dateFormat.dateFormat = "yyyy"
            let year = dateFormat.string(from: date)
            dateFormat.dateFormat = "MM"
            let month = dateFormat.string(from: date)
            dateFormat.dateFormat = "dd"
            let day = dateFormat.string(from: date)
            dateFormat.dateFormat = "HH"
            let hour = dateFormat.string(from: date)
            print(year, month, day, hour)
        }
    }

//        let dateFormatOne = DateFormatter()
//        dateFormatOne.dateFormat = "yyyy"
//
//        if let year = dateFormatOne.date(from: "\(time)") {
//            return "\(year)"
//        }
//
//        let dateFormatTwo = DateFormatter()
//        dateFormatTwo.dateFormat = "MM"
//
//        if let month = dateFormatTwo.date(from: "\(time)") {
//
//            return "\(month)"
//        }
//        let dateFormatThree = DateFormatter()
//        dateFormatThree.dateFormat = "DD"
//
//        if let newDay = dateFormatThree.date(from: "\(time)") {
//
//            return "\(newDay)"
//        }
//        let dateFormatFour = DateFormatter()
//        dateFormatFour.dateFormat = "HH"
//
//        if let newHour = dateFormatFour.date(from: "\(time)") {
//
//            return "\(newHour)"
//        }
//        return "empty"



//
//    func startTimeToDateType() -> String {
//        let date = Date(millis: startTime)
//
//        let dateFormatter = DateFormatter()
//
//        return dateFormatter.string(from: date)
//
//    }

}

struct BookingDate: Equatable {

    let year: Int
    let month: Int
    let day: Int

    static func == (lhs: BookingDate, rhs: BookingDate) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
    }

    func dateString() -> String {

        return "\(year) 年 \(month) 月 \(day) 日"
    }
}
