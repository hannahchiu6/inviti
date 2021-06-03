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
        return lhs.startTime == rhs.startTime && lhs.endTime  == rhs.endTime
    }

    var id: String
    var owner: SimpleUser
    var startTime: Int64
    var endTime: Int64
    var date: Int
    var subject: String
    var location: String
//    let notes: String
//    let participants: String
//    let location: String

    enum CodingKeys: String, CodingKey {
        case id, owner, startTime, endTime, subject, date, location
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
            "id": id,
            "owner": owner.toDict,
            "startTime": startTime,
            "endTime": endTime,
            "subject": subject,
            "date": date,
//            "notes": notes as Any,
//            "participants": participants as Any,
            "location": location as Any
        ]
    }
//
//    func returnTimeToDateType(time: Int64) -> Date {
//
//        let dateFormat = DateFormatter()
//        dateFormat.dateFormat = "yyyy"
//        if let newDate = dateFormat.date(from: "\(time)") {
//            return newDate
//        }
//
//        return Date()
//
//    }

    func startTimeToTime() -> String {

        return  Date.timeFormatter.string(from: Date.init(millis: startTime))

    }

    func endTimeToTime() -> String {

        return  Date.timeFormatter.string(from: Date.init(millis: endTime))

    }

    func startTimeToYear() -> String {

        return  Date.yearFormatter.string(from: Date.init(millis: startTime))

    }

    func endTimeToYear() -> String {

        return  Date.yearFormatter.string(from: Date.init(millis: endTime))

    }


    func startTimeToDate() -> String {

        return  Date.dateFormatter.string(from: Date.init(millis: startTime))

    }

    func endTimeToDate() -> String {

        return  Date.dateFormatter.string(from: Date.init(millis: endTime))

    }

//    func returnDay(time: Int64) -> Int {
//
//        let dateFormat = DateFormatter()
//        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        if let dateTest = dateFormat.date(from: "\(time)") {
//
//            return dateTest.day
//        }
//        return 0
//
//    }

//    func returnFormat(time: Int64) {
//
//        let dateFormat = DateFormatter()
//        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        if let date = dateFormat.date(from: "\(time)") {
//
//            dateFormat.dateFormat = "yyyy"
//            let year = dateFormat.string(from: date)
//            dateFormat.dateFormat = "MM"
//            let month = dateFormat.string(from: date)
//            dateFormat.dateFormat = "dd"
//            let day = dateFormat.string(from: date)
//            dateFormat.dateFormat = "HH"
//            let hour = dateFormat.string(from: date)
//            print(year, month, day, hour)
//        }
//    }

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
