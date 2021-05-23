//
//  OptionalSettingsCell.swift.swift
//  inviti
//
//  Created by Hannah.C on 17.05.21.
//

import UIKit
import SwiftHEXColors

//protocol ThirdCellDelegate {
//    func getNotesData(_ notes: String)
//    func getSingleData(_ boolean: Bool)
//    func getHiddenData(_ boolean: Bool)
//    func getDeadlineData(_ boolean: Bool)
//    func getDeadlineDayData(_ day: Int)
//
//}


class OptionalSettingsCell: UITableViewCell{

    var viewModel = CreateViewModel()

//    var delegate: ThirdCellDelegate?

    var deadlineTag: Int = 0

    var placeholder = UILabel()

    var observation : NSKeyValueObservation?
    
    @IBOutlet weak var singleView: UISwitch!

    @IBOutlet weak var hiddenView: UISwitch!

    @IBOutlet weak var deadlineView: UISwitch!

    @IBOutlet weak var dealineFullView: UIView!

    @IBAction func singleToggle(_ sender: UISwitch) {
        if sender.isOn {

//            delegate?.getSingleData(true)
            viewModel.meetingSingleChanged(true)
        }
    }

    @IBAction func hiddenToggle(_ sender: UISwitch) {
        if sender.isOn {

//            delegate?.getHiddenData(true)
            viewModel.meetingHiddenChanged(sender.isOn)
        }
    }

    @IBOutlet weak var textView: UITextView!

    @IBOutlet weak var deadlineLabel: UILabel!

    @IBOutlet weak var addSubtract: UIStepper!

    @IBAction func deadlineToggle(_ sender: UISwitch) {

        if sender.isOn {

            UIView.animate(withDuration: 0.5) {

                self.dealineFullView.isHidden = false
//                self.delegate?.getDeadlineData(sender.isOn)
                self.viewModel.meetingDeadlineChanged(sender.isOn)
            }

        } else {

                self.dealineFullView.isHidden = true
//                self.delegate?.getDeadlineData(false)

        }

//        deadlineView.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)

    }



//    @objc func switchChanged(mySwitch: UISwitch) {
//        let value = mySwitch.isOn
//        // Do something


    @IBAction func stepperAction(_ sender: UIStepper) {

        let count = Int(sender.value)
        self.deadlineLabel.text = "投票的天數為 \(count) 天"
//        delegate?.getDeadlineDayData(count)
        viewModel.onDeadlineTagChanged(count)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.dealineFullView.isHidden = true

        textView.delegate = self

        setLayout()

        observation = addSubtract.observe(\.value, options: [.old, .new], changeHandler: { (stepper, change) in
                if change.newValue! == 0.0 {
                    if change.newValue! > change.oldValue! {
                        stepper.value = 1
                    } else {
                        stepper.value = -1
                    }
                }
            })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCell(model: Meeting) {
        textView.text = model.notes
        singleView.isOn = model.singleMeeting
        hiddenView.isOn = model.hiddenMeeting
        deadlineView.isOn = model.deadlineMeeting
        deadlineTag = model.deadlineTag
//        placeholder.alpha = 0
//        placeholder.text = ""
        
        if deadlineTag != 0 {
            dealineFullView.isHidden = false

            self.deadlineLabel.text = "投票的天數為 \(deadlineTag) 天"
        } else {
            dealineFullView.isHidden = true
        }

    }

    func setLayout() {
//        placeholder.frame = CGRect(x: 8, y: 4, width: 250, height: 36)
//
//            placeholder.text = "請描述問題或提交反饋，謝謝。"
//            placeholder.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
//            placeholder.backgroundColor?.withAlphaComponent(0)
//            placeholder.font = UIFont.systemFont(ofSize: 17)

//        contentTextView.addSubview(placeholder)

        placeholder.frame = CGRect(x: 6, y: 6, width: 250, height: 36)
        placeholder.text = ""
        placeholder.textColor = UIColor.hexStringToUIColor(hex: "B8B8B8")
        placeholder.backgroundColor?.withAlphaComponent(0)
        placeholder.font = UIFont(name: "PingFang TC", size: 17)
        textView.addSubview(placeholder)
    }

}


extension OptionalSettingsCell: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        print("textViewDidChange!!!!!!!!")
        guard let notes = textView.text else {
            return
        }
//        delegate?.getNotesData(notes)

        if textView.text.isEmpty {
             placeholder.alpha = 1
            } else {
             placeholder.alpha = 0
             placeholder.text = ""
             viewModel.onNotesChanged(text: notes)
            }

    }
}
