//
//  DateHelper.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation

extension Date {

    var millisecondsSince1970: Int64 {
           return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
       }

    init(millis: Int64) {
           self = Date(timeIntervalSince1970: TimeInterval(millis) / 1000)
       }

    static var dateFormatter: DateFormatter {

        let formatter = DateFormatter()

        formatter.dateFormat = "yyyy.MM.dd"

        return formatter

    }

//    // 將時間戳轉換成 TimeInterval
//    let timeInterval = TimeInterval(timestamp)
//    // 初始化一個 Date
//    let date = Date(timeIntervalSince1970: timeInterval)
//    // 實例化一個 DateFormatter
//    let dateFormatter = DateFormatter()
//    // 設定日期格式
//    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
}
