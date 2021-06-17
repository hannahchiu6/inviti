//
//  VotingTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit
import SwiftHEXColors

class ResultTableViewCell: UITableViewCell {
    
    var optionViewModels = SelectOptionViewModel()
    
    var votingViewModel: VotingViewModel?
    
    var meetingID: String?
    
    var user: User?
    
    var optionID: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor.midGray
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor.white
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBOutlet weak var checkCircle: UIImageView!
    
    @IBOutlet weak var emptyCircle: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var voteCountLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var cellBackgroundView: UIView!
    
    func setupVotingCell(model: OptionViewModel, index: Int) {
        
        let startTime = model.option.makeStartTimeToString()
        
        let endTime = model.option.makeEndTimeToString()
        
        titleLabel.text = model.option.optionTime?.makeDateToString()
        
        valueLabel.text = "\(startTime) - \(endTime)"
        
    }
    
    func setupNoCell(model: OptionViewModel, index: Int) {
        
        let startTime = model.option.makeStartTimeToString()
        
        let endTime = model.option.makeEndTimeToString()
        
        titleLabel.text = model.option.optionTime?.makeDateToString()
        
        valueLabel.text = "\(startTime) - \(endTime)"
        
        self.voteCountLabel.text = "0"
        
        self.voteCountLabel.textColor = UIColor.gray
        
        self.checkCircle.isHidden = true
        
        self.emptyCircle.isHidden = false
        
        
    }
    
    func setupYesCell(model: OptionViewModel, index: Int) {
        
        let startTime = model.option.makeStartTimeToString()
        
        let endTime = model.option.makeEndTimeToString()
        
        titleLabel.text = model.option.optionTime?.makeDateToString()
        
        valueLabel.text = "\(startTime) - \(endTime)"
        
        guard let count = model.selectedOptions?.count else { return }
        
        if index == 0 {
            
            let redColor = UIColor.mainOrange
            
            voteCountLabel.text = String(describing: count)
            
            voteCountLabel.textColor = redColor
            
            self.emptyCircle.isHidden = true
            
            self.checkCircle.isHidden = false
            
            titleLabel.textColor = redColor
            
            valueLabel.textColor = redColor
            
        } else {
            
            self.voteCountLabel.text = String(describing: count)
            
            self.voteCountLabel.textColor = UIColor.lightGray
            
            self.emptyCircle.isHidden = true
            
            self.checkCircle.isHidden = false
            
            self.checkCircle.tintColor = UIColor.gray
            
        }
        
    }
    
}
