//
//  CreateFirstTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 17.05.21.
//

import UIKit
import SwiftHEXColors

protocol CreateFirstCellDelegate {
    func goToSecondPage()
    func getSubjectData(_ subject: String)
    func getLocationData(_ location: String)
}

class CreateFirstCell: UITableViewCell {

    var delegate: CreateFirstCellDelegate?

    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!

    @IBAction func addSubject(_ sender: UITextField) {
        guard let subject = sender.text else {
            return
        }
        delegate?.getSubjectData(subject)
    }

    @IBAction func addLocation(_ sender: UITextField) {
        guard let location = sender.text else {
            return
        }
        delegate?.getLocationData(location)
    }

    @IBAction func selectTimeIcon(_ sender: Any) {
        print("test Btn selectime icon!")
        delegate?.goToSecondPage()
    }

    @IBAction func selectTime(_ sender: Any) {
        delegate?.goToSecondPage()
        print("test Btn selectime!")
    }
    
    @IBOutlet weak var timePicker: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCell(model: Meeting) {
        subjectTextField.text = model.subject
        locationTextField.text = model.location
    }
}
