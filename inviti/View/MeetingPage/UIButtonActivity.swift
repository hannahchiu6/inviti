//
//  UIButtonActivity.swift
//  inviti
//
//  Created by Hannah.C on 15.05.21.
//

import Foundation
import UIKit

class UIButtonActivity: UIButton {

    @IBInspectable var indicatorColor : UIColor = .lightGray

    private var buttonLabel: String?

    func startAnimating() {
        self.isEnabled = false

        buttonLabel = self.titleLabel?.text
        self.setTitle("", for: .normal)

        let indicator = UIActivityIndicatorView()
        indicator.color = indicatorColor
        indicator.hidesWhenStopped = true

        let buttonHeight = self.bounds.size.height
        let buttonWidth = self.bounds.size.width
        indicator.center = CGPoint(x: buttonWidth / 2, y: buttonHeight / 2)

        let scale = max(min((self.frame.size.height - 4) / 21, 2.0), 0.0)
        let transform: CGAffineTransform = CGAffineTransform(scaleX: scale, y: scale)
        indicator.transform = transform

        self.addSubview(indicator)
        indicator.startAnimating()
    }

    func stopAnimating() {
        self.isEnabled = true

        if let titleLabel = buttonLabel {
            self.setTitle(titleLabel, for: .normal)
        }

        if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
    }
}
