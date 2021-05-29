//
//  OptionsCell.swift
//  inviti
//
//  Created by Hannah.C on 17.05.21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

protocol SecondCellDelegate: AnyObject{
    func goToSecondPage()

}

class OptionsCell: UITableViewCell {

    var viewModel = CreateOptionViewModel()

    var optionViewModels = SelectVMController()

    var meetingInfo: Meeting?

    @IBOutlet weak var optionsStackView: UIStackView!

    @IBOutlet weak var goSecondPage: UIButton!

    @IBOutlet weak var goSecondPageIcon: UIButton!

    @IBOutlet weak var bottomAlarmIcon: UIImageView!
    
    @IBAction func deleteOption(_ sender: UIButton) {
        let deleteItem = optionViewModels.optionViewModels.value[sender.tag]
        print(sender.tag)
        optionViewModels.onTap(with: sender.tag, meeting: meetingInfo!)

    }
    
    @IBOutlet weak var deleteXview: UIButton!

    @IBOutlet weak var yearLabel: UILabel!

    @IBOutlet weak var startTimeLabel: UILabel!

    @IBOutlet weak var endTimeLabel: UILabel!

    @IBAction func goNextPage(_ sender: Any) {
        delegate?.goToSecondPage()
    }

    @IBOutlet weak var timePickerViewTop: UIStackView!

//    @IBAction func goNextPageIcon(_ sender: Any) {
//        delegate?.goToSecondPage()
//    }

    weak var delegate: SecondCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupEmptyDataCell() {
        timePickerViewTop.isHidden = false
        optionsStackView.isHidden = true
        deleteXview.isEnabled = false
    }

    func setupCell(model: OptionViewModel, index: Int) {
        timePickerViewTop.isHidden = true
        deleteXview.isEnabled = true
        optionsStackView.isHidden = false

        yearLabel.text = model.option.optionTime?.dateString()
        startTimeLabel.text = model.option.startTimeToTime()
        endTimeLabel.text = model.option.endTimeToTime()

        if index == 0 {
            bottomAlarmIcon.isHidden = false
        } else {
            bottomAlarmIcon.isHidden = true
        }


    }

}
