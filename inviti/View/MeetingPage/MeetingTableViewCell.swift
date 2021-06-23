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
    @IBOutlet weak var userView: UIImageView!
    @IBOutlet weak var userTwoView: UIImageView!
    @IBOutlet weak var userThreeView: UIImageView!
    @IBOutlet weak var participanCountLabel: UILabel!
    @IBOutlet weak var meetingTimeLabel: UILabel!
    @IBOutlet weak var meetingSubject: UILabel!
    @IBOutlet weak var editIcon: UIButton!
    @IBOutlet weak var deleteIcon: UIButton!
    @IBOutlet weak var voteIcon: UIButton!
    
    
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
    
    var mainViewModel = MainViewModel()
    
    var index: Int?
    
    var meeting: Meeting?
    
    var completionHandler: ((Int) -> Void)?
    
    func setup(viewModel: MeetingViewModel) {
        self.viewModel = viewModel
        layoutCell()
    }
    
    func layoutCell() {
        
        if mainViewModel.isVoted {
            
            voteIcon.isEnabled = false
            
        } else {
            
            voteIcon.isEnabled = true
        }
        
        guard let meeting = viewModel?.meeting else { return }
        
        if meeting.isClosed {
            
            editIcon.isEnabled = false
            
            voteIcon.isEnabled = false
            
            editIcon.tintColor = UIColor.gray
            
        } else {
            
            editIcon.isEnabled = true
            
            editIcon.tintColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00)
        }
        
        meetingSubject.text = viewModel?.subject
        meetingTimeLabel.text = "created-time".localized + "\(Date.pointFormatter.string(from: Date.init(millis: viewModel!.createdTime)))"
        
        guard let url = viewModel?.image else { return }
        let imageUrl = URL(string: String(url))
        hostImage.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "moon.circle.fill"))
        
        guard let users = viewModel?.participants else { return }
        
        switch users.count {
        case 0:
            participanCountLabel.text = "nobody-vote-yet".localized
            userView.isHidden = true
            userTwoView.isHidden = true
            userThreeView.isHidden = true
            
        case 1:
            participanCountLabel.text = "one-participant-voted".localized
            userTwoView.isHidden = true
            userThreeView.isHidden = true
            userView.isHidden = false
        case 2:
            participanCountLabel.text = "two-participant-voted".localized
            userThreeView.isHidden = true
            userView.isHidden = false
            userTwoView.isHidden = false
            
        case 3:
            participanCountLabel.text = "three-participant-voted".localized
            userThreeView.isHidden = false
            userView.isHidden = false
            userTwoView.isHidden = false
            
        default: // > 3
            
            participanCountLabel.text = "and-other".localized + " \(String(describing: users.count - 3)) " + "participants".localized
            userThreeView.isHidden = false
            userView.isHidden = false
            userTwoView.isHidden = false
        }
        
    }
    
    func setupImage(imageURL: String, view: UIImageView) {
        
        let userImageUrl = URL(string: imageURL)
        
        view.kf.setImage(with: userImageUrl, placeholder: UIImage(systemName: "moon.circle.fill"))
    }
    
    func setupParticipatedCell() {
        
        editIcon.isHidden = true
        deleteIcon.isHidden = true
        voteIcon.isHidden = true
    }
    
    func setUpView() {
        
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bgView.layer.shadowRadius = 6
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.masksToBounds = false
        
        userView.layer.cornerRadius = userView.layer.frame.width / 2
        userTwoView.layer.cornerRadius = userTwoView.layer.frame.width / 2
        userThreeView.layer.cornerRadius = userThreeView.layer.frame.width / 2
        hostImage.layer.cornerRadius = hostImage.layer.frame.width / 2
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 8
        
    }
}

extension UIStackView {
    func insertArrangedSubview(_ view: UIView, belowArrangedSubview subview: UIView) {
        arrangedSubviews.enumerated().forEach {
            if $0.1 == subview {
                insertArrangedSubview(view, at: $0.0 + 1)
            }
        }
    }
    
    func insertArrangedSubview(_ view: UIView, aboveArrangedSubview subview: UIView) {
        arrangedSubviews.enumerated().forEach {
            if $0.1 == subview {
                insertArrangedSubview(view, at: $0.0)
            }
        }
    }
}
