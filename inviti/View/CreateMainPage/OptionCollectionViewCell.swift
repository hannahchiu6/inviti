//
//  OptionCollectionViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class OptionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bgView: UIView!

    func roundCorners(cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: bottomView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))

        let maskLayer = CAShapeLayer()
        maskLayer.frame = bottomView.bounds
        maskLayer.path = path.cgPath
        bottomView.layer.mask = maskLayer

    }

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.4
        layer.masksToBounds = false

        layer.backgroundColor = UIColor.clear.cgColor

        contentView.layer.masksToBounds = true
        bottomView.layer.cornerRadius = 8
        roundCorners(cornerRadius: 8.0)
    }


}
