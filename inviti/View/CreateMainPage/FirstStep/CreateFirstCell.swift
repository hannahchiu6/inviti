//
//  CreateFirstTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 17.05.21.
//

import UIKit

//protocol CreateFirstCellDelegate: AnyObject {
//    func getSubjectData(_ subject: String)
//    func getLocationData(_ location: String)
//}

class CreateFirstCell: UITableViewCell {
    
    //    weak var delegate: CreateFirstCellDelegate?
    
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
        //        delegate?.getSubjectData(subject)
        createViewModel.onSubjectChanged(text: subject)
        
        //        subjectCellEmpty = !subjectCellEmpty
        //
        //        NotificationCenter.default.post(name: UITextField.textDidChangeNotification, object: nil)
        
    }
    
    @IBAction func addLocation(_ sender: UITextField) {
        guard let location = sender.text else {
            return
        }
        //        delegate?.getLocationData(location)
        createViewModel.onLocationChanged(text: location)
        
        //        locationCellEmpty = !locationCellEmpty
        //
        //        NotificationCenter.default.post(name: UITextField.textDidChangeNotification, object: nil)
        
    }
    
    func setup(viewModel: MeetingViewModel) {
        //        self.viewModel = viewModel
        
        subjectTextField.text = viewModel.subject
        locationTextField.text = viewModel.location
        
        //        layoutCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    //    func layoutCell() {
    //
    //        subjectTextField.text = viewModel?.subject
    //
    //        locationTextField.text = viewModel?.location
    //
    //
    //    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
