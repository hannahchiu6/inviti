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

       self.layer.backgroundColor = UIColor.white.cgColor

       self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.systemGray5.cgColor
       self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
       self.layer.shadowOpacity = 1.0
       self.layer.shadowRadius = 0.0

        
    }
    
    func setupEmptyCell() {
        
        invitesLabel.text = "\n" + "a09".localized
        
        voteBtnView.setTitle("a10".localized, for: .normal)
        
        rejectBtnView.isHidden = true
        
        ownerImage.isHidden = false
        
        deleteBtnView.isHidden = true
    }
    
    func setupVoteCell(model: NotificationViewModel) {
        if let whoSend = model.notification.ownerName,
           let subject = model.notification.subject {
            
            let time = model.notification.makeTimeToDateString()
            
            invitesLabel.text = "\(whoSend)" + "a06".localized + "\(time)" + "a07".localized + "\(subject)" + "a08".localized
        }
        
        voteBtnView.isHidden = true
        
        rejectBtnView.isHidden = true
        
        ownerImage.isHidden = false
        
        guard let url = model.notification.image else { return }
        
        let imageUrl = URL(string: String(url))
        
        ownerImage.kf.setImage(with: imageUrl)

        deleteBtnView.isHidden = false
    }
    
    
    func setupInviteCell(model: NotificationViewModel) {
        
        // whoSend = 活動主辦人
        if let whoSend = model.notification.ownerName,
           let subject = model.notification.subject {
            
            invitesLabel.text = "\(whoSend)" + "a04".localized + "\(subject)" + "a05".localized
        }
        
        ownerImage.isHidden = false
        
        rejectBtnView.isHidden = true
        
        voteBtnView.isHidden = true
        
        guard let url = model.notification.image else { return }
        
        let imageUrl = URL(string: String(url))
        
        ownerImage.kf.setImage(with: imageUrl)

        deleteBtnView.isHidden = false
    }
    
    
    func setupEventCell(model: NotificationViewModel) {
        if let whoSend = model.ownerName,
           let subject = model.subject {
            
            invitesLabel.text = "a01".localized  + "\(subject)" + "a02".localized + "\(whoSend)" + "a03".localized
        }
        
        ownerImage.isHidden = false
        
        rejectBtnView.isHidden = true
        
        voteBtnView.isHidden = true

        deleteBtnView.isHidden = false
        
        
        guard let url = model.notification.image else { return }
        
        let imageUrl = URL(string: String(url))
        
        ownerImage.kf.setImage(with: imageUrl)
        
    }
    
    
}
