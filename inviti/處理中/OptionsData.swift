//
//  OptionsData.swift
//  inviti
//
//  Created by Hannah.C on 23.05.21.
//

import Foundation

struct OptionsData: Equatable, Comparable {

    static func < (lhs: OptionsData, rhs: OptionsData) -> Bool {

        return lhs.date.year == rhs.date.year
                ? lhs.date.month == rhs.date.month
                    ? lhs.date.day < rhs.date.day
                    : lhs.date.month < rhs.date.month
                : lhs.date.year < rhs.date.year
    }

    static func == (lhs: OptionsData, rhs: OptionsData) -> Bool {
        return lhs.hour == rhs.hour && lhs.date == rhs.date
    }

    let date: OptionTime
    var hour: [Int] {

        didSet {

            self.hour.sort(by: <)
        }
    }

    var subject: String
    var location: String

    var toDict: [String: Any] {
        return [
            "date": date.toDict as Any,
            "hour": [hour] as Any,
            "subject": subject as Any,
            "location": [location] as Any

        ]
    }

//    init? (dictionary: [String: Any]) {
//
//        guard let day = dictionary[FBBookingKey.day.rawValue] as? Int else { return nil }
//
//        guard let year = dictionary[FBBookingKey.year.rawValue] as? Int else { return nil }
//
//        guard let month = dictionary[FBBookingKey.month.rawValue] as? Int else { return nil }
//
//        guard let hours = dictionary[FBBookingKey.hours.rawValue] as? [Int] else { return nil }
//
//        if let subject = dictionary[FBBookingKey.subject.rawValue] as? String {
//
//            self.subject = subject
//
//        } else {
//
//            self.subject = "還沒投票喔！"
//        }
//        if let location = dictionary[FBBookingKey.location.rawValue] as? String {
//
//            self.location = location
//        } else {
//
//            self.location = "0"
//        }
//        self.date = OptionTime(year: year, month: month, day: day)
//        self.hour = hours
//    }
//
//    init(date: OptionTime, hours: [Int], subject: String, location: String) {
//
//        self.date = date
//        self.hour = hours
//        self.subject = subject
//        self.location = location
//    }

    func hoursCount() -> Int {

        return hour.count
    }

    func hoursString() -> String {

        return "你選了 \(hoursCount()) 小時"
    }
    func hoursStringOnebyOne() -> String {
        var text = ""

        for time in hour {

            if time == hour.first {

                text += ("\(String(time)):00")
            } else {

                text += ("\n\(String(time)):00")
            }
        }
        return text
    }

    func returnTotalPrice() -> String {

        guard let intPrice = Int(location) else { return "舊資料" }
        let price = String(intPrice * hoursCount())
        return price
    }

    func returnDateText() -> String {

        let year = date.year
        let month = date.month
        let day = date.day
        return "\(year) 年 \(month) 月 \(day) 日"
    }

}

struct OptionTime: Equatable {

    let year: Int
    let month: Int
    let day: Int

    static func == (lhs: OptionTime, rhs: OptionTime) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
    }

    var toDict: [String: Any] {
        return [
            "year": year as Any,
            "month": month as Any,
            "day": day as Any
        ]
    }

    func dateString() -> String {

        return "\(year) 年 \(month) 月 \(day) 日"
    }
}
