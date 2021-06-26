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
    
    func makeDateToString() -> String {
        
        return "\(year)" + "year-for-option".localized + "\(month)".localized + "\(day)" + "day-for-option".localized
    }
    
    func makeDatetoString() -> String {
        
        if month < 10 {
            
            if day < 10 {
                
                return "\(year)0\(month)0\(day)"
            }
            
            return "\(year)0\(month)\(day)"
            
        } else {
            
            if day < 10 {
                
                return "\(year)\(month)0\(day)"
            }
            
            return "\(year)\(month)\(day)"
            
        }
    }
    
    func makeDateToInt() -> Int {
        
        if month < 10 {
            
            if day < 10 {
                
                return Int("\(year)0\(month)0\(day)") ?? 0
            }
            
            return Int("\(year)0\(month)\(day)") ?? 0
            
        } else {
            
            if day < 10 {
                
                return Int("\(year)\(month)0\(day)") ?? 0
            }
            
            return Int("\(year)\(month)\(day)") ?? 0
            
        }
    }
}
