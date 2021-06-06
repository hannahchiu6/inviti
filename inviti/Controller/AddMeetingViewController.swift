//
//  AddMeetingViewController.swift
//  inviti
//
//  Created by Hannah.C on 05.06.21.
//

import UIKit

protocol AddMeetingVCDelegate: AnyObject {
    func didtap()
}

class AddMeetingViewController: BaseViewController {

    weak var delegate: AddMeetingVCDelegate?

    var notificationVM = UpdateNotificationVM()

    var viewModel = AddViewModel()

    @IBAction func searchMeetingID(_ sender: Any) {
        
    }

    @IBOutlet weak var searchField: UITextField! {
        didSet {
            self.searchField.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func returnButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }

    @IBAction func goToVote(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Voting", bundle: nil)
        let votingVC = storyboard.instantiateViewController(identifier: "VotingVC")
           guard let voting = votingVC as? VotingViewController else { return }

        voting.meetingInfo = viewModel.meetingInfo

        self.viewModel.updateParticipants()

        delegate?.didtap()

        notificationVM.createOwnerNotification(type: TypeName.vote.rawValue, meetingID: viewModel.meetingInfo.id, ownerID: viewModel.meetingInfo.ownerAppleID)

        self.navigationController?.pushViewController(voting, animated: true)

    }


    @IBOutlet weak var voteBtnView: UIButton!

}


extension AddMeetingViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {

        guard let text = searchField.text else { return }

        if !text.isEmpty {
            viewModel.fetchData(meetingID: text)
        }
    }
}
