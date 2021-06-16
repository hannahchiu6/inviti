//
//  UIStackView+Extension.swift
//  inviti
//
//  Created by Hannah.C on 14.06.21.
//

import Foundation
import UIKit

public extension UIStackView {

    convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0.0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill
        ) {
        
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }


    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }


    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
    }
}

enum UserImages: String {
    
    case first = "person.circle.fill"

    case second = "face.smiling.fill"

    case third = "moon.stars.fill"
}
