//
//  CreateFirstTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 17.05.21.
//

import UIKit

class CreateFirstCell: UITableViewCell {
    
    @IBOutlet weak var subjectTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    var subjectCellEmpty: Bool = true
    
    var locationCellEmpty: Bool = true
    
    var viewModel: MeetingViewModel?
    
    var createViewModel = CreateMeetingViewModel()
    
    @IBAction func addSubject(_ sender: UITextField) {
        guard let subject = sender.text else {
            return
        }

        createViewModel.onSubjectChanged(text: subject)
    }
    
    @IBAction func addLocation(_ sender: UITextField) {
        guard let location = sender.text else {
            return
        }

        createViewModel.onLocationChanged(text: location)

    }
    
    func setup(viewModel: MeetingViewModel) {
        
        subjectTextField.text = viewModel.subject
        locationTextField.text = viewModel.location

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        subjectTextField.delegate = self
        locationTextField.delegate = self
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension CreateFirstCell: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let currentText = textField.text ?? ""

        guard let stringRange = Range(range, in: currentText) else { return false }

        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        return updatedText.count <= 16
    }

}
