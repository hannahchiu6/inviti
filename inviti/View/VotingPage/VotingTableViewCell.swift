//
//  VotingTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class VotingTableViewCell: UITableViewCell {

    var optionViewModels = SelectOptionViewModel()

    var votingViewModel: VotingViewModel?

    var meetingID: String?

    var user: User?

    var optionID: String?

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

        votingViewModel?.onSelectedUserAdded(user?.appleID ?? "5gWVjg7xTHElu9p6Jkl1")

        votingViewModel?.createWithEmptyData(with: optionID!, meetingID: meetingID!, selectedOption: &votingViewModel!.selectedOption)
    }

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var valueLabel: UILabel!

    @IBOutlet weak var cellBackgroundView: UIView!


    func setupVotingCell(model: OptionViewModel, index: Int) {

        let startTime = model.option.startTimeToTime()
        
        let endTime = model.option.endTimeToTime()

        titleLabel.text = model.option.optionTime?.dateString()
        
        valueLabel.text = "\(startTime) - \(endTime)"

        selectionStyle = UITableViewCell.SelectionStyle.none

        checkBoxView.tag = index

    }

    
}
