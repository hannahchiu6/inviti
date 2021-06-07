//
//  CreateFirstTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 17.05.21.
//

import UIKit

protocol CreateFirstCellDelegate: AnyObject {
    func getSubjectData(_ subject: String)
    func getLocationData(_ location: String)
}

class CreateFirstCell: UITableViewCell {

    weak var delegate: CreateFirstCellDelegate?

//    var createMeetingViewModel = CreateMeetingViewModel()

    var viewModel = MeetingViewModel(model: Meeting(id: "", owner: SimpleUser(id: "", email: "", image: ""), ownerAppleID: "", createdTime: 0, subject: "", location: "", notes: "", image: "", singleMeeting: false, hiddenMeeting: false, deadlineMeeting: false, participants: nil, numOfParticipants: nil, deadlineTag: nil))

    @IBOutlet weak var subjectTextField: UITextField!

    @IBOutlet weak var locationTextField: UITextField!

    var subjectCellEmpty: Bool = true

    var locationCellEmpty: Bool = true

    @IBAction func addSubject(_ sender: UITextField) {
        guard let subject = sender.text else {
            return
        }
        delegate?.getSubjectData(subject)

//        subjectCellEmpty = !subjectCellEmpty
//
//        NotificationCenter.default.post(name: UITextField.textDidChangeNotification, object: nil)

    }

    @IBAction func addLocation(_ sender: UITextField) {
        guard let location = sender.text else {
            return
        }
        delegate?.getLocationData(location)

//        locationCellEmpty = !locationCellEmpty
//
//        NotificationCenter.default.post(name: UITextField.textDidChangeNotification, object: nil)

    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCell(model: MeetingViewModel) {
        subjectTextField.text = model.meeting.subject
        locationTextField.text = model.meeting.location
    }

}
