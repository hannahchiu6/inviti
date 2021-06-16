//
//  ResultsTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    var viewModel = VotingViewModel()
    
    var meetingID: String = ""
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func closeStatusBtn(_ sender: Any) {
    }
    
    @IBOutlet weak var closeStatusBtnView: UIButton!
    @IBOutlet weak var noOfParticipantsLabel: UILabel!
    @IBOutlet weak var createdTimeLabel: UILabel!
    @IBOutlet weak var meetingSubject: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        
    }
    
    func setupView() {
        bgView.layer.cornerRadius = 5
        
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        bgView.layer.shadowRadius = 6
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.masksToBounds = false
        
        mainView.frame = CGRect(x: 0, y: 0, width: self.frame.width * 0.3, height: self.frame.height * 0.4)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupCell(model: MeetingViewModel) {
        noOfParticipantsLabel.text = "參與投票人數為 \(String(describing: model.numOfParticipants)) 人"
        meetingSubject.text = model.subject
        
        createdTimeLabel.text = "投票建立時間：\(Date.intDateFormatter.string(from: Date.init(millis: model.createdTime)))"
        
    }
    
}
