//
//  OptionsCell.swift
//  inviti
//
//  Created by Hannah.C on 17.05.21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

protocol SecondCellDelegate {
    func goToSecondPage()

}

class OptionsCell: UITableViewCell {

    var viewModel = CreateViewModel()

    var optionViewModels = SelectVMController()

    var meetingInfo: Meeting?

    @IBOutlet weak var optionsStackView: UIStackView!

    @IBOutlet weak var goSecondPage: UIButton!

    @IBOutlet weak var goSecondPageIcon: UIButton!

    @IBOutlet weak var bottomAlarmIcon: UIImageView!
    
    @IBAction func deleteOption(_ sender: UIButton) {
        let deleteItem = optionViewModels.optionViewModels.value[sender.tag]
//        print(sender.tag)
//        optionViewModels.onTap(with: sender.tag, meeting: meetingInfo!)
        deleteOption(index: sender.tag, meeting: meetingInfo!)
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

    var delegate: SecondCellDelegate?

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

//        yearLabel.text = model.optionTime?.dateString()
        startTimeLabel.text = model.option.startTimeToTime()
        endTimeLabel.text = model.option.endTimeToTime()

        if index == 0 {
            bottomAlarmIcon.isHidden = false
        } else {
            bottomAlarmIcon.isHidden = true
        }


    }



    func deleteOption(index: Int, meeting: Meeting) {

//        var db = Firestore.firestore()

        let option = optionViewModels.optionViewModels.value[index]

        let docRef = Firestore.firestore().collection("meetings").document(meeting.id).collection("options")

        docRef.document(option.id).delete()
        
//        db.collection("meetings").document(meeting.id).collection("options").document(option.id).delete() { error in
//
//            if let error = error {
//
//                completion(.failure(error))
//
//            } else {
//                print("delete success")
//                completion(.success(option.id))
//            }
//        }
    }

}
