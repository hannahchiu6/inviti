//
//  VotingTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class VotingTableViewCell: UITableViewCell {

    var optionViewModels = SelectVMController()

    var meeting: Meeting?

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBOutlet weak var checkBoxView: CheckBoxButton!
    
    @IBAction func checkBox(_ sender: Any) {
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!


    func setupCell(model: OptionViewModel, index: Int) {

        let startTime = model.option.startTimeToTime()
        let endTime = model.option.endTimeToTime()
        let date = Date.dateFormatter.string(from: model.option.startTimeToDate())

        titleLabel.text = date
        
        valueLabel.text = "\(startTime) - \(endTime)"

        selectionStyle = UITableViewCell.SelectionStyle.none

        checkBoxView.tag = index


    }
}

