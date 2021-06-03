//
//  MeetingTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit
import Kingfisher

protocol MeetingTableCellDelegate: AnyObject {
    func editButtonPressed(_ sender: MeetingTableViewCell)
    func goButtonPressed(_ sender: MeetingTableViewCell)
    func deleteBtnPressed(_ sender: MeetingTableViewCell)
}

class MeetingTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var hostImage: UIImageView!
    @IBOutlet weak var participantStackView: UIStackView!
    @IBOutlet weak var firstParticipantView: UIImageView!
    @IBOutlet weak var secondParticipantView: UIImageView!
    @IBOutlet weak var thirdParticipantView: UIImageView!
    @IBOutlet weak var participanCountLabel: UILabel!
    @IBOutlet weak var meetingTimeLabel: UILabel!
    @IBOutlet weak var meetingSubject: UILabel!
    @IBOutlet weak var editIcon: UIButton!

    @IBAction func edit(_ sender: Any) {
        delegate?.editButtonPressed(self)

        if let index = index {
            completionHandler?(index)
        }
    }

    @IBAction func participate(_ sender: Any) {
        delegate?.goButtonPressed(self)
    }

    @IBAction func deleteBtn(_ sender: Any) {
        delegate?.deleteBtnPressed(self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setUpView()

        selectionStyle = .none
    }

    weak var delegate: MeetingTableCellDelegate?

    var viewModel: MeetingViewModel?

    var index: Int?

    var meeting: Meeting?

    var completionHandler: ((Int) -> Void)?

    func setup(viewModel: MeetingViewModel) {
        self.viewModel = viewModel
        layoutCell()
    }

    func layoutCell() {
        
        meeting = viewModel?.meeting
        meetingSubject.text = viewModel?.subject
        meetingTimeLabel.text = "投票建立時間：\(Date.pointFormatter.string(from: Date.init(millis: viewModel!.createdTime)))"
        participanCountLabel.text = "和其他 \(String(describing: viewModel!.numOfParticipants)) 位參與者"

        guard let url = viewModel?.image else { return }
            let imageUrl = URL(string: String(url))
            hostImage.kf.setImage(with: imageUrl)

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

    }
}
