//
//  String + Extension.swift
//  inviti
//
//  Created by Hannah.C on 16.05.21.
//

import Foundation
import SwiftyMenu

extension String: SwiftyMenuDisplayable {
    public var retrievableValue: Any {
        return self
    }

    public var displayableValue: String {
        return self
    }
}
