//
//  OptionalSettingsCell.swift.swift
//  inviti
//
//  Created by Hannah.C on 17.05.21.
//

import UIKit
import SwiftHEXColors

//protocol CreateFirstCellDelegate {
//    func goToSecondPage()
//}

class OptionalSettingsCell: UITableViewCell, UITextViewDelegate {

//   var delegate: CreateFirstCellDelegate?

    @IBOutlet weak var subjectTextField: UITextField!
    
    @IBOutlet weak var dealineFullView: UIView!

    @IBAction func singleToggle(_ sender: Any) {
    }
    @IBAction func hiddenToggle(_ sender: Any) {
    }
    @IBOutlet weak var textView: UITextView!

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

    var placeholder = UILabel()

    @IBAction func stepperAction(_ sender: UIStepper) {
        let count = Int(sender.value)
        deadlineTag = count
        self.deadlineLabel.text = "投票的天數為 \(count) 天"
    }

    @IBOutlet weak var deadlineView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.dealineFullView.isHidden = true
        textView.delegate = self
        setLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func textViewDidChange(_ textView: UITextView) {

        if textView.text.isEmpty {
             placeholder.alpha = 1
            } else {
             placeholder.alpha = 0
             placeholder.text = ""
            }
    }

    func setLayout() {

        placeholder.frame = CGRect(x: 6, y: 6, width: 250, height: 36)
        placeholder.text = "Add note"
        placeholder.textColor = UIColor.hexStringToUIColor(hex: "B8B8B8")
        placeholder.backgroundColor?.withAlphaComponent(0)
        placeholder.font = UIFont(name: "PingFang TC", size: 17)
        textView.addSubview(placeholder)
    }
}
