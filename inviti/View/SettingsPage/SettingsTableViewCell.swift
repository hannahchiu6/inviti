//
//  SettingsTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.backgroundColor = UIColor.clear
//        self.cellBackgroundView.layer.borderWidth = 1
//        self.cellBackgroundView.layer.borderColor = UIColor(red: 0.0471, green: 0.0431, blue: 0.0431, alpha: 0.2).cgColor
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowOffset = CGSize(width: 0, height: 3)
//        self.layer.shadowRadius = 0
//        self.layer.shadowColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var nextImage: UIImageView!
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let margins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
//        contentView.frame = contentView.frame.inset(by: margins)
//        contentView.layer.cornerRadius = 8
//        self.cellBackgroundView.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
//        self.cellBackgroundView.layer.masksToBounds = true
//        self.cellBackgroundView.layer.shouldRasterize = true
//    }
}
