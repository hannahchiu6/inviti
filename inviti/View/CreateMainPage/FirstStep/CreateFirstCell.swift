//
//  CreateFirstTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 17.05.21.
//

import UIKit

protocol CreateFirstCellDelegate {
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
