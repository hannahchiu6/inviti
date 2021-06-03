//
//  ForCalendar.swift
//  inviti
//
//  Created by Hannah.C on 23.05.21.
//

import Foundation
import UIKit

private enum PBColor: String {

    case colorGreen
    case endColor
    case lightGreen
    case lightMoreGreen
    case colorPinkRed
    case textColor
}

extension UIColor {

    static let myColorGreen = PBColor(.colorGreen)
    static let myColorEnd = PBColor(.endColor)
    static let myColorLightGreen = PBColor(.lightGreen)
    static let myColorLightMoreGreen = PBColor(.lightMoreGreen)
    static let myColorPinkRed = PBColor(.colorPinkRed)
    static let textColor = PBColor(.textColor)

    private static func PBColor(_ color: PBColor) -> UIColor? {

        return UIColor(named: color.rawValue)
    }
}
