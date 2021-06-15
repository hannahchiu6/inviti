//
//  UILabel+Extension.swift
//  inviti
//
//  Created by Hannah.C on 24.05.21.
//

import Foundation
import UIKit

@IBDesignable
extension UILabel {

    @IBInspectable var characterSpacing: CGFloat {

        set {

            if let labelText = text, labelText.isEmpty == false {

                let attributedString = NSMutableAttributedString(attributedString: attributedText!)

                attributedString.addAttribute(
                    NSAttributedString.Key.kern,
                    value: newValue,
                    range: NSRange(location: 0, length: attributedString.length - 1)
                )

                attributedText = attributedString
            }
        }

        get {
            guard let spacing = attributedText?.value(
                forKey: NSAttributedString.Key.kern.rawValue
            ) as? CGFloat else { return 0 }
            return spacing
        }

    }

    func setTextSpacingBy(value: Double, linespacing: CGFloat) {

        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: value,
                                          range: NSRange(location: 0, length: attributedString.length - 1))
            let nsmutable = NSMutableParagraphStyle()
            nsmutable.lineSpacing = linespacing
            attributedString.addAttribute(
                NSAttributedString.Key.paragraphStyle,
                value: nsmutable,
                range: NSMakeRange(0, attributedString.length)
            )

            attributedText = attributedString
        }
    }
    func setupTextInPB(text: String?, value: Double = 0.75, linespacing: CGFloat = 2.25) {
        self.text = text
        setTextSpacingBy(value: value, linespacing: linespacing)
    }

}
