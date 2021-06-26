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
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
