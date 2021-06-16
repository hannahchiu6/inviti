//
//  Array+Extension.swift
//  inviti
//
//  Created by Hannah.C on 13.06.21.
//

import Foundation

extension Array where Element: Equatable {

    mutating func removeIf(object: Element) {

        if let index = firstIndex(of: object) {

            remove(at: index)

        }
    }
    
}
