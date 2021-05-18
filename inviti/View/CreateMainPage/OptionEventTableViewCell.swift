//
//  OptionEventTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 14.05.21.
//

import UIKit

class OptionEventTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        mainView.layer.shadowRadius = 8
        mainView.layer.shadowOpacity = 0.2
        layer.masksToBounds = true

        layer.backgroundColor = UIColor.clear.cgColor

        contentView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 8
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
