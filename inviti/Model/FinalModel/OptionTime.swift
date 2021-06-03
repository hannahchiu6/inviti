//
//  OptionTime.swift
//  inviti
//
//  Created by Hannah.C on 26.05.21.
//

import Foundation

struct OptionTime: Equatable, Codable {
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
