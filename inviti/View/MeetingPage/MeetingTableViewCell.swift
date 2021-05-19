//
//  MeetingTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

protocol MeetingTableCellDelegate {
    func editButtonPressed()
    func goButtonPressed()
    func deleteBtnPressed()
}

class MeetingTableViewCell: UITableViewCell {

    var delegate: MeetingTableCellDelegate?

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
        delegate?.editButtonPressed()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setUpView()
    }

    @IBAction func participate(_ sender: Any) {
        delegate?.goButtonPressed()
    }

    @IBAction func deleteBtn(_ sender: Any) {
        delegate?.deleteBtnPressed()
    }

    func setUpView() {

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
