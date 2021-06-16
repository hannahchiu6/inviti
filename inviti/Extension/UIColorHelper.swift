////
////  ColorHelper.swift
////  inviti
////
////  Created by Hannah.C on 20.05.21.
////
//import UIKit
//import  SwiftHEXColors
//
//private enum Color: String {
//
//    case deepPurple = "#673ab7"
//
//    case indigo = "#3f51b5"
//
//    case orange = "#ff9800"
//
//    case red = "#f44336"
//
//    case green = "#4caf50"
//
//}
//
//extension UIColor {
//
//    static let deepPurple = color(.deepPurple)
//
//    static let indigo = color(.indigo)
//
//    static let orange = color(.orange)
//
//    static let red = color(.red)
//
//    static let green = color(.green)
//
//    private static func color(_ color: Color) -> UIColor {
//
//        return UIColor.hexStringToUIColor(hex: color.rawValue)
//    }
//
//    static func hexStringToUIColor(hex: String) -> UIColor {
//
//        var colorString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//
//        if colorString.hasPrefix("#") {
//            colorString.remove(at: colorString.startIndex)
//        }
//
//        if (colorString.count) != 6 {
//            return UIColor.gray
//        }
//
//        var rgbValue: UInt32 = 0
//        Scanner(string: colorString).scanHexInt32(&rgbValue)
//
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }
// }
