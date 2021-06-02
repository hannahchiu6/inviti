//
//  VotingTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

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
        
//        if sender.isSelected {
//
//
//        } else {
//
//        }
//
//        votingViewModel?.onSelectedUserAdded(user?.appleID ?? "5gWVjg7xTHElu9p6Jkl1")
//
//        votingViewModel?.createWithEmptyData(with: optionID!, meetingID: meetingID!, selectedOption: &votingViewModel!.selectedOption)

        if sender.isSelected {

            votingViewModel?.onVotingChanged(false)

        } else {

            votingViewModel?.onVotingChanged(true)
        }

        votingViewModel?.onSelectedUserAdded(user?.appleID ?? "5gWVjg7xTHElu9p6Jkl1")

        votingViewModel?.createWithEmptyData(with: optionID!, meetingID: meetingID!, selectedOption: &votingViewModel!.selectedOption)
    }

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var voteCountLabel: UILabel!

    @IBOutlet weak var valueLabel: UILabel!

    @IBOutlet weak var cellBackgroundView: UIView!


    func setupVotingCell(model: OptionViewModel, index: Int) {

        let startTime = model.option.startTimeToTime()

        let endTime = model.option.endTimeToTime()

        titleLabel.text = model.option.optionTime?.dateString()

        valueLabel.text = "\(startTime) - \(endTime)"

        checkBoxView.tag = index

    }
    
    func setupYesCell(model: OptionViewModel, index: Int) {
        
        let startTime = model.option.startTimeToTime()

        let endTime = model.option.endTimeToTime()

        titleLabel.text = model.option.optionTime?.dateString()

        valueLabel.text = "\(startTime) - \(endTime)"

        if let yesCount = model.selectedOptions?.count {

            if yesCount > 0 && index == 0 {

                let redColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00)

                voteCountLabel.text = "\(yesCount)"

                voteCountLabel.textColor = redColor

                checkBoxView.image(for: .normal)

                titleLabel.textColor = redColor

                valueLabel.textColor = redColor

            } else if yesCount > 0 {

                self.voteCountLabel.text = "\(yesCount)"

                self.voteCountLabel.textColor = UIColor.gray

                self.checkBoxView.image(for: .normal)

            } else {

                self.voteCountLabel.text = "0"

                self.voteCountLabel.textColor = UIColor.gray

                self.checkBoxView.image(for: .highlighted)

            }
        }

        checkBoxView.isEnabled = false

        selectionStyle = UITableViewCell.SelectionStyle.none

    }

    func setupFirstYesCell(model: OptionViewModel) {

        if let yesCount = model.selectedOptions?.count {

            let redColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00)

            voteCountLabel.text = "\(yesCount)"

            voteCountLabel.textColor = redColor

            checkBoxView.image(for: .selected)

            titleLabel.textColor = redColor

            valueLabel.textColor = redColor
        }
    }


}
