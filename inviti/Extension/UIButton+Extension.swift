//
//  UIButton+Extension.swift
//  inviti
//
//  Created by Hannah.C on 17.05.21.
//

import UIKit

//public enum UIButtonBorderSide {
//    case top, bottom, left, right
//}

//extension UIButton {
//    func loadingIndicator(show show: Bool) {
//        let tag = 6666
//        if show {
//            let indicator = UIActivityIndicatorView()
//            let buttonHeight = self.bounds.size.height
//            let buttonWidth = self.bounds.size.width
//            indicator.center = CGPoint(x: buttonWidth / 2, y: buttonHeight / 2)
//            indicator.tag = tag
//            self.addSubview(indicator)
//            indicator.startAnimating()
//        } else {
//            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
//                indicator.stopAnimating()
//                indicator.removeFromSuperview()
//            }
//        }
//    }


//    func addBorder(side: UIButtonBorderSide, color: UIColor, width: CGFloat) {
//        let border = CALayer()
//        border.backgroundColor = color.cgColor
//
//        switch side {
//        case .top:
//            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
//        case .bottom:
//            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
//        case .left:
//            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
//        case .right:
//            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
//        }
//
//        self.layer.addSublayer(border)
//    }
//
//
//}
