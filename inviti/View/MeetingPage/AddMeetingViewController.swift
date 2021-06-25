//
//  AddMeetingViewController.swift
//  inviti
//
//  Created by Hannah.C on 05.06.21.
//

import UIKit

protocol AddMeetingVCDelegate: AnyObject {
    func didtap()
    func returnToMain()
}

class AddMeetingViewController: BaseViewController {
    
    weak var delegate: AddMeetingVCDelegate?
    
    var notificationVM = UpdateNotificationVM()
    
    var viewModel = AddViewModel()
    
    @IBOutlet weak var goVoteBtnView: UIButton!
    
    @IBAction func goVoteButton(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Voting", bundle: nil)
        let votingVC = storyboard.instantiateViewController(identifier: "VotingVC")
        guard let voting = votingVC as? VotingViewController else { return }
        
        let model = notificationVM.meetingViewModels.value
        
        if !model.isEmpty {
            
            voting.meetingInfo = model[0].meeting
            
            let meetingID = model[0].id
            let ownerID = model[0].ownerAppleID
            
            self.viewModel.updateParticipantData(meetingID: meetingID)
            
            notificationVM.createOwnerNotification(type: TypeName.vote.rawValue, meetingID: meetingID, ownerID: ownerID)
            
        }
        
        delegate?.didtap()
        
        self.navigationController?.pushViewController(voting, animated: true)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
        guard let text = searchField.text else { return }
        
        searchStackView.isHidden = false

        self.goVoteBtnView.isHidden = true
        
        if !text.isEmpty {
            
            notificationVM.fetchOneMeeitngData(meetingID: text)
            
            notificationVM.onFetched = { [weak self] () in
                
                if let model = self?.notificationVM.meetingViewModels.value {
                    
                    if text == model[0].meeting.numberForSearch {
                        
                        self?.notificationVM.fetchUserToSelf(userID: model[0].ownerAppleID)
                        
                        self?.notificationVM.meeting = self?.viewModel.meeting
                        
                        self?.notificationVM.onSubjectChanged(model[0].subject ?? "")
                        
                        self?.notificationVM.onNotiMeetingIDAdded(model[0].id)
                        
                        self?.notificationVM.onImageChanged(model[0].image ?? "")
                        
                        guard let subject = model[0].subject else { return }
                        
                        self?.searchResultLabel.text = subject

                        self?.goVoteBtnView.isHidden = false
                        
                    }

                }
            }
            self.searchResultLabel.text = "no-result".localized
        }
        
    }
    
    @IBOutlet weak var searchResultLabel: UILabel!
    
    @IBOutlet weak var searchStackView: UIStackView!
    
    @IBOutlet weak var searchField: UITextField! {
        didSet {
            self.searchField.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchStackView.isHidden = true
        
        
    }
    
    @IBAction func returnButton(_ sender: UIButton) {
        
        delegate?.returnToMain()
    }
}

extension AddMeetingViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = searchField.text else { return }
        
        if !text.isEmpty {
            
            notificationVM.fetchOneMeeitngData(meetingID: text)

        }
    }
}
