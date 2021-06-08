//
//  VotingTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

protocol VotingTableViewCellDelegate: AnyObject {
    func didVote(_ votedOne: Bool)
}

class VotingTableViewCell: UITableViewCell {

    weak var delegate: VotingTableViewCellDelegate?

    var optionViewModels = SelectOptionViewModel()

    var votingViewModel: VotingViewModel?

    var meetingID: String?

    var user: User?

    var optionID: String?

    var userUID = UserDefaults.standard.array(forKey: "uid")

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBOutlet weak var checkBoxView: CheckBoxButton!
    
    @IBAction func checkBox(_ sender: UIButton) {
        
        if sender.isSelected {

            votingViewModel?.onVotingChanged(false)

        } else {

            votingViewModel?.onVotingChanged(true)

        }

        if votingViewModel?.optionViewModels.value[sender.tag].selectedOptions != nil {
            delegate?.didVote(true)

        } else {
            
            delegate?.didVote(false)
        }

        votingViewModel?.createWithEmptyData(with: optionID!, meetingID: meetingID!, selectedOption: &votingViewModel!.selectedOption)
    }

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var valueLabel: UILabel!

    @IBOutlet weak var cellBackgroundView: UIView!


    func setupIfVoted() {
        
        checkBoxView.isHidden = true
    }

    func setupVotingCell(model: OptionViewModel, index: Int) {

        let startTime = model.option.startTimeToTime()
        
        let endTime = model.option.endTimeToTime()

        titleLabel.text = model.option.optionTime?.dateString()
        
        valueLabel.text = "\(startTime) - \(endTime)"

        selectionStyle = UITableViewCell.SelectionStyle.none

        checkBoxView.tag = index

    }

    
}
