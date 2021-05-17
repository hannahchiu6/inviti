//
//  CreateFirstTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 17.05.21.
//

import UIKit

class CreateFirstTableViewCell: UITableViewCell {
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!

    @IBAction func selectTimeIcon(_ sender: Any) {
    }
   

    @IBOutlet weak var dealineFullView: UIView!

    @IBAction func selectTime(_ sender: Any) {
    }
    @IBOutlet weak var timePicker: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBAction func singleToggle(_ sender: Any) {
    }
    @IBAction func hiddenToggle(_ sender: Any) {
    }


    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var addSubtract: UIStepper!

    @IBAction func deadlineToggle(_ sender: UISwitch) {
        if sender.isOn {
            UIView.animate(withDuration: 0.5) {
                self.dealineFullView.isHidden = false
            }
        } else {
         self.dealineFullView.isHidden = true
        }
    }
    var deadlineTag: Int = 0

    @IBAction func stepperAction(_ sender: UIStepper) {
        let count = Int(sender.value)
        deadlineTag = count
        self.deadlineLabel.text = "投票的天數為 \(count) 天"
    }

    @IBOutlet weak var deadlineView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.dealineFullView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
