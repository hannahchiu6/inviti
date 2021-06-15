//
//  NewsEventTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class NewsEventTableViewCell: UITableViewCell {

    @IBOutlet weak var hostImg: UIImageView!

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var thirdPersonView: UIImageView!
    @IBOutlet weak var secondPersonView: UIImageView!
    @IBOutlet weak var firstPersonView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var voteView: UIButton!
    @IBAction func vote(_ sender: Any) {
    }
    @IBOutlet weak var subjectLabel: UILabel!

    @IBOutlet weak var subtitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        setUpView()
    }

    func setUpView() {
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowColor = UIColor.lightGray.cgColor
        contentView.layer.masksToBounds = false

        firstPersonView.layer.cornerRadius = firstPersonView.layer.frame.width / 2
        secondPersonView.layer.cornerRadius = secondPersonView.layer.frame.width / 2
        thirdPersonView.layer.cornerRadius = thirdPersonView.layer.frame.width / 2
        hostImg.layer.cornerRadius = hostImg.layer.frame.width / 2
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        contentView.frame = contentView.frame.inset(by: margins)
        bgView.layer.cornerRadius = 8
    }
}
