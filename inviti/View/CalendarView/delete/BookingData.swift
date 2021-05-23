//
//  BookingData.swift
//  inviti
//
//  Created by Hannah.C on 23.05.21.
//

import Foundation

//
//  BookingData.swift
//  PlayBand
//
//  Created by 姜旦旦 on 2019/4/8.
//  Copyright © 2019 姜旦旦. All rights reserved.
//


struct BookingTimeAndRoom: Equatable, Comparable {

    static func < (lhs: BookingTimeAndRoom, rhs: BookingTimeAndRoom) -> Bool {

        return lhs.date.year == rhs.date.year
                ? lhs.date.month == rhs.date.month
                    ? lhs.date.day < rhs.date.day
                    : lhs.date.month < rhs.date.month
                : lhs.date.year < rhs.date.year
    }
    static func == (lhs: BookingTimeAndRoom, rhs: BookingTimeAndRoom) -> Bool {
        return lhs.hour == rhs.hour && lhs.date == rhs.date
    }

    let date: BookingDate
    var hour: [Int] {

        didSet {

            self.hour.sort(by: <)
        }
    }
    var room: String
    var price: String

    init? (dictionary: [String: Any]) {

        guard let day = dictionary[FirebaseBookingKey.day.rawValue] as? Int else {return nil}
        guard let year = dictionary[FirebaseBookingKey.year.rawValue] as? Int else {return nil}
        guard let month = dictionary[FirebaseBookingKey.month.rawValue] as? Int else {return nil}
        guard let hours = dictionary[FirebaseBookingKey.hours.rawValue] as? [Int] else {return nil}

        if let room = dictionary[FirebaseBookingKey.room.rawValue] as? String {

            self.room = room
        } else {

            self.room = "之前還沒選"
        }
        if let price = dictionary[FirebaseBookingKey.price.rawValue] as? String {

            self.price = price
        } else {

            self.price = "0"
        }
        self.date = BookingDate(year: year, month: month, day: day)
        self.hour = hours
    }
    init(date: BookingDate, hour: [Int], room: String, price: String) {

        self.date = date
        self.hour = hour
        self.room = room
        self.price = price
    }

    func hoursCount() -> Int {

        return hour.count
    }

    func hoursString() -> String {

        return "總共 \(hoursCount()) 小時"
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

        guard let intPrice = Int(price) else {return "舊資料"}
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
