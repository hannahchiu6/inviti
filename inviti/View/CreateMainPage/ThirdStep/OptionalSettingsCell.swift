//
//  OptionalSettingsCell.swift.swift
//  inviti
//
//  Created by Hannah.C on 17.05.21.
//

import UIKit
import SwiftHEXColors


class OptionalSettingsCell: UITableViewCell{

    var viewModel = CreateMeetingViewModel()

    var deadlineTag: Int = 0

    var placeholder = UILabel()

    var observation : NSKeyValueObservation?
    
    @IBOutlet weak var singleView: UISwitch!

    @IBOutlet weak var hiddenView: UISwitch!

    @IBOutlet weak var deadlineView: UISwitch!

    @IBOutlet weak var dealineFullView: UIView!

    @IBAction func singleToggle(_ sender: UISwitch) {
        if sender.isOn {

            viewModel.meetingSingleChanged(true)
        } else {
            viewModel.meetingSingleChanged(false)
        }
    }

    @IBAction func hiddenToggle(_ sender: UISwitch) {
        if sender.isOn {

            viewModel.meetingHiddenChanged(true)
        } else {
            viewModel.meetingSingleChanged(false)
        }
    }

    @IBOutlet weak var textView: UITextView!

    @IBOutlet weak var deadlineLabel: UILabel!

    @IBOutlet weak var addSubtract: UIStepper!

    @IBAction func deadlineToggle(_ sender: UISwitch) {

        if sender.isOn {

            UIView.animate(withDuration: 0.5) {

                self.dealineFullView.isHidden = false

                self.viewModel.meetingDeadlineChanged(sender.isOn)
            }

        } else {

                self.dealineFullView.isHidden = true

        }


    }

    @IBAction func stepperAction(_ sender: UIStepper) {

        let count = Int(sender.value)
        self.deadlineLabel.text = "投票的天數為 \(count) 天"
        viewModel.onDeadlineTagChanged(count)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.dealineFullView.isHidden = true

        textView.delegate = self

        setLayout()

        observation = addSubtract.observe(\.value, options: [.old, .new], changeHandler: { stepper, change in
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

    func setCell(model: MeetingViewModel) {
        textView.text = model.meeting.notes
        singleView.isOn = model.meeting.singleMeeting
        hiddenView.isOn = model.meeting.hiddenMeeting
        deadlineView.isOn = model.meeting.deadlineMeeting
        deadlineTag = model.meeting.deadlineTag ?? 0

        if deadlineTag != 0 {
            dealineFullView.isHidden = false

            self.deadlineLabel.text = "投票的天數為 \(deadlineTag) 天"
        } else {
            dealineFullView.isHidden = true
        }

    }

    func setLayout() {

        placeholder.frame = CGRect(x: 6, y: 6, width: 250, height: 36)
        placeholder.text = ""
        placeholder.textColor = UIColor(red: 0.9922, green: 0.9098, blue: 0.8784, alpha: 1.0) 
        placeholder.backgroundColor?.withAlphaComponent(0)
        placeholder.font = UIFont(name: "PingFang TC", size: 17)
        textView.addSubview(placeholder)
    }

}


extension OptionalSettingsCell: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {

        guard let notes = textView.text else {
            return
        }

        if textView.text.isEmpty {

             placeholder.alpha = 1

            } else {

             placeholder.alpha = 0
             placeholder.text = ""
             viewModel.onNotesChanged(text: notes)

            }

    }
}
