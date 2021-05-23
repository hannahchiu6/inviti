//
//   setupButtonModel.swift
//  inviti
//
//  Created by Hannah.C on 23.05.21.
//

import Foundation
import UIKit

extension UIButton {

    func setupButtonModelPlayBand() {

        self.layoutIfNeeded()
        let gradientLayer = CALayer.getPBGradientLayer(bounds: self.bounds)
        self.layer.insertSublayer(gradientLayer, below: self.imageView?.layer)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 19
        self.clipsToBounds = true
    }
}

extension CALayer {

    static func getPBGradientLayer (bounds: CGRect, cornerRadius: CGFloat = 0) -> CAGradientLayer {

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        guard let startColor = UIColor.myColorEnd else {return gradientLayer}
        guard let endColor = UIColor.myColorLightGreen else {return gradientLayer}
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = cornerRadius
        return gradientLayer
    }
}
