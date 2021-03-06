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
    
    func toMillis(date: Date) -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    static var yearFormatter: DateFormatter {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy"
        
        return formatter
        
    }
    
    static var monthFormatter: DateFormatter {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM"
        
        return formatter
        
    }
    
    static var dayFormatter: DateFormatter {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd"
        
        return formatter
        
    }
    
    static var hourFormatter: DateFormatter {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "HH"
        
        return formatter
        
    }
    
    static var timeFormatter: DateFormatter {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "HH:mm"
        
        return formatter
        
    }
    
    static var minFormatter: DateFormatter {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "mm"
        
        return formatter
        
    }
    
    static var dateFormatter: DateFormatter {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        return formatter
        
    }
    
    static var intDateFormatter: DateFormatter {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyyMMdd"
        
        return formatter
        
    }
    
    static var pointFormatter: DateFormatter {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy.MM.dd"
        
        return formatter
        
    }
}

extension Date {
    var intVal: Int? {
        if let dateTest = Date.coordinate {
            let inteval = Date().timeIntervalSince(dateTest)
            return Int(inteval)
        }
        return nil
    }
    
    
    // today's time is close to `2020-04-17 05:06:06`
    
    static let coordinate: Date? = {
        let dateFormatCoordinate = DateFormatter()
        dateFormatCoordinate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let dateTest = dateFormatCoordinate.date(from: "2021-05-29 15:06:06") {
            return dateTest
        }
        return nil
    }()
}


extension Int {
    
    var dateVal: Date? {
        // convert Int to Double
        let interval = Double(self)
        if let dateTest = Date.coordinate {
            return  Date(timeInterval: interval, since: dateTest)
        }
        return nil
    }
}
