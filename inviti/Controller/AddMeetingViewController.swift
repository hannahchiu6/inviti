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

    @IBOutlet weak var goVoteBtnView: UIButton!

    @IBAction func goVoteButton(_ sender: Any) {

        let storyboard: UIStoryboard = UIStoryboard(name: "Voting", bundle: nil)
        let votingVC = storyboard.instantiateViewController(identifier: "VotingVC")
           guard let voting = votingVC as? VotingViewController else { return }

        self.viewModel.updateParticipantData()

        voting.meetingInfo = viewModel.meeting

        delegate?.didtap()

        notificationVM.createOwnerNotification(type: TypeName.vote.rawValue, meetingID: viewModel.meeting.id, ownerID: viewModel.meeting.ownerAppleID)

        self.navigationController?.pushViewController(voting, animated: true)
    }

    @IBAction func searchButton(_ sender: Any) {


        guard let text = searchField.text else { return }

        searchStackView.isHidden = false

        if !text.isEmpty {

            if text == viewModel.meeting.id {

                notificationVM.fetchUserToSelf(userID: viewModel.meeting.ownerAppleID)

                 notificationVM.meeting = viewModel.meeting

                notificationVM.onSubjectChanged(viewModel.meeting.subject ?? "")

                guard let subject = viewModel.meeting.subject else { return }

                searchResultLabel.text = subject

            } else {

                goVoteBtnView.isHidden = true

                searchResultLabel.text = "查無此活動，請重新輸入。"

            }

        } else {

            goVoteBtnView.isHidden = true

            searchResultLabel.text = "請輸入活動邀請碼。"

        }

    }

    @IBOutlet weak var searchResultLabel: UILabel!

    @IBOutlet weak var searchStackView: UIStackView!

    @IBOutlet weak var searchField: UITextField! {
        didSet {
            self.searchField.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        searchStackView.isHidden = true

    }

    @IBAction func returnButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
}

extension AddMeetingViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {

        guard let text = searchField.text else { return }

        if !text.isEmpty {
            viewModel.fetchData(meetingID: text)
        }
    }
}
