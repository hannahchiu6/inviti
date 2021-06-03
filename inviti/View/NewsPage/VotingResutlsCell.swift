//
//  VotingResutlsCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class VotingResutlsCell: UITableViewCell {

    // top 3 part
    @IBOutlet weak var thirdWhoVoteYesLabel: UILabel!
    @IBOutlet weak var thirdTimeLabel: UILabel!
    @IBOutlet weak var thirdDateLabel: UILabel!
    @IBOutlet weak var thirdYearLabel: UILabel!

    // top 2 part
    @IBOutlet weak var secondWhoVoteYesLabel: UILabel!
    @IBOutlet weak var secondTimeLabel: UILabel!
    @IBOutlet weak var secondDateLabel: UILabel!
    @IBOutlet weak var secondYearLabel: UILabel!

    // top 1 part
    @IBOutlet weak var topWhoVoteYesLabel: UILabel!
    @IBOutlet weak var topTimeLabel: UILabel!
    @IBOutlet weak var topDateLabel: UILabel!
    @IBOutlet weak var topYearLabel: UILabel!

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

        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)


        }

    }
