//
//  InvitesTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 06.06.21.
//

import UIKit

class InvitesTableViewCell: UITableViewCell {
    
    var viewModel = UpdateNotificationVM()

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none

        setUpBasicView()

    }

    @IBOutlet weak var ownerImage: UIImageView!

    @IBOutlet weak var invitesLabel: UILabel!

    @IBAction func goVoteButton(_ sender: Any) {
    }

    @IBOutlet weak var deleteBtnView: UIButton!

    @IBAction func deleteButton(_ sender: UIButton) {

        viewModel.onTap(withIndex: sender.tag)
    }

    @IBOutlet weak var rejectBtnView: UIButton!

    @IBOutlet weak var voteBtnView: UIButton!

    @IBAction func rejectButton(_ sender: Any) {

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

    func setUpBasicView() {

        ownerImage.layer.cornerRadius = ownerImage.bounds.width / 2

    }

    func setupEmptyCell() {

        invitesLabel.text = "\n" + "您尚未有活動的邀請或通知。"

        voteBtnView.setTitle("發起投票活動", for: .normal)

        rejectBtnView.isHidden = true

        ownerImage.isHidden = true

        deleteBtnView.isHidden = true
    }

    func setupVoteCell(model: NotificationViewModel) {
        if let whoSend = model.notification.ownerName,
           let subject = model.notification.subject {

           let time = model.notification.makeTimeToDateString()
            
            invitesLabel.text = "\(whoSend) 已於 \(time) 收到您的「\(subject)」投票邀請，並已加入投票。"
        }

        voteBtnView.isHidden = true

        rejectBtnView.isHidden = true

        ownerImage.isHidden = false

        guard let url = model.notification.image else { return }

            let imageUrl = URL(string: String(url))

            ownerImage.kf.setImage(with: imageUrl)
    }


    func setupInviteCell(model: NotificationViewModel) {

        // whoSend = 活動主辦人
        if let whoSend = model.notification.ownerName,
           let subject = model.notification.subject {

        invitesLabel.text = "\(whoSend) 邀請您參加「\(subject)」活動，您可以直接前往投票，選出適合的時間。"
        }

        ownerImage.isHidden = false

        rejectBtnView.isHidden = true

        voteBtnView.isHidden = true

        guard let url = model.notification.image else { return }

            let imageUrl = URL(string: String(url))

            ownerImage.kf.setImage(with: imageUrl)
    }


    func setupEventCell(model: NotificationViewModel) {
        if let whoSend = model.ownerName,
           let subject = model.subject {

            let time = model.notification.makeTimeToDateString()

            invitesLabel.text = "「\(subject)」投票已結束，\(whoSend) 已將最終票選時間加入您的行事曆囉！"
        }

        ownerImage.isHidden = false

        rejectBtnView.isHidden = true

        voteBtnView.isHidden = true


        guard let url = model.notification.image else { return }

            let imageUrl = URL(string: String(url))

            ownerImage.kf.setImage(with: imageUrl)

    }


}
