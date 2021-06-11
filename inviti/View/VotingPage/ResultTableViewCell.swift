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
        selectedBackgroundView?.backgroundColor = UIColor(red: 1, green: 0.9373, blue: 0.9294, alpha: 1.0)
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

        let startTime = model.option.startTimeToTime()

        let endTime = model.option.endTimeToTime()

        titleLabel.text = model.option.optionTime?.dateString()

        valueLabel.text = "\(startTime) - \(endTime)"

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

                self.emptyCircle.isHidden = true

                self.checkCircle.isHidden = false

                titleLabel.textColor = redColor

                valueLabel.textColor = redColor

            } else if yesCount > 0 {

                self.voteCountLabel.text = "\(yesCount)"

                self.voteCountLabel.textColor = UIColor.gray

                self.emptyCircle.isHidden = true

                self.checkCircle.isHidden = false

                self.checkCircle.tintColor = UIColor.gray

            } else {

                self.voteCountLabel.text = "0"

                self.voteCountLabel.textColor = UIColor.gray

                self.checkCircle.isHidden = true

                self.emptyCircle.isHidden = false

            }
        }

    }

}
