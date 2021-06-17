//
//  ColorHelper.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import UIKit
import SwiftHEXColors

private enum INColor: String {

    case mainOrange = "#FF5C26"

    case darkGray = "#7D736F"

    case lightOrange = "#FDE8E0"

    case lightBrown = "#7D695B"

    case darkBrown = "#564448"

    case lightGray = "#ededed"

    case midGray = "bfbfbf"

}

extension UIColor {

    static let mainOrange = INColor(.mainOrange)

    static let darkGray = INColor(.darkGray)

    static let lightOrange = INColor(.lightOrange)

    static let lightBrown = INColor(.lightBrown)

    static let darkBrown = INColor(.darkBrown)

    static let lightGray = INColor(.lightGray)

    static let midGray = INColor(.midGray)

    private static func INColor(_ color: INColor) -> UIColor? {

        return UIColor(named: color.rawValue)

    }

    static func hexStringToUIColor(hex: String) -> UIColor {

        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
           Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
