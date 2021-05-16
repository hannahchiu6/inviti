//
//  MeetingTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class MeetingTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var hostImage: UIImageView!
    @IBOutlet weak var participantStackView: UIStackView!
    @IBOutlet weak var firstParticipantView: UIImageView!
    @IBOutlet weak var secondParticipantView: UIImageView!
    @IBOutlet weak var thirdParticipantView: UIImageView!
    @IBOutlet weak var participanCountLabel: UILabel!
    @IBOutlet weak var pollTimeLabe: UILabel!
    @IBOutlet weak var pollSubject: UILabel!
    @IBOutlet weak var editIcon: UIButton!

    @IBAction func edit(_ sender: Any) {
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setUpView()
    }

    func setUpView() {


       
//        bgView.layer.borderWidth = 1
//        bgView.layer.borderColor = UIColor(red: 0.0471, green: 0.0431, blue: 0.0431, alpha: 0.2).cgColor
        bgView.layer.shadowOpacity = 0.6
        bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bgView.layer.shadowRadius = 3
        bgView.layer.shadowColor = UIColor.lightGray.cgColor
        bgView.layer.masksToBounds = false

        firstParticipantView.layer.cornerRadius = firstParticipantView.layer.frame.width / 2
        secondParticipantView.layer.cornerRadius = secondParticipantView.layer.frame.width / 2
        thirdParticipantView.layer.cornerRadius = thirdParticipantView.layer.frame.width / 2
        hostImage.layer.cornerRadius = hostImage.layer.frame.width / 2

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 8
//        self.bgView.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
//        self.bgView.layer.masksToBounds = true
//        self.bgView.layer.shouldRasterize = true
    }
}
