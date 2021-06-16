//
//  BookingDate.swift
//  inviti
//
//  Created by Hannah.C on 16.06.21.
//

import Foundation

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
