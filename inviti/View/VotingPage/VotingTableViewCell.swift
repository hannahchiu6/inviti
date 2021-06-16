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

    @IBOutlet weak var voteImage: UIImageView!

    weak var delegate: VotingTableViewCellDelegate?

    var optionViewModels = SelectOptionViewModel()

    var votingViewModel: VotingViewModel?

    var meetingID: String?

    var user: User?

    var isVoted: Bool = false

    var optionID: String?

    var userUID = UserDefaults.standard.string(forKey: UserDefaults.Keys.uid.rawValue) ?? ""

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBOutlet weak var checkBoxView: CheckBoxButton!
    
    @IBAction func checkBox(_ sender: UIButton) {

    }

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var valueLabel: UILabel!

    @IBOutlet weak var cellBackgroundView: UIView!


    func setupIfVoted() {
        
        checkBoxView.isHidden = true
    }

    func setupVotingCell(model: OptionViewModel, index: Int) {

        let startTime = model.option.makeStartTimeToString()
        
        let endTime = model.option.makeEndTimeToString()

        titleLabel.text = model.option.optionTime?.makeDateToString()
        
        valueLabel.text = "\(startTime) - \(endTime)"

        checkBoxView.tag = index

    }

    func votedYesCell() {

        checkBoxView.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)

    }

    func votedNoCell() {

        checkBoxView.setImage(UIImage(systemName: "poweroff"), for: .normal)

    }

    
}
