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
//    var owner: SimpleUser
//    var ownerAppleID: String
    var startTime: Int64
    var endTime: Int64
    var date: Int
    var subject: String
    var location: String
//    let notes: String
//    let participants: String
//    let location: String

    enum CodingKeys: String, CodingKey {
        case id, startTime, endTime, subject, date, location
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
//            "ownerAppleID": ownerAppleID,
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
