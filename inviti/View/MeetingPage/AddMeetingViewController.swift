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

            if let meetingID = model[0].id as? String,
               let ownerID = model[0].ownerAppleID as? String {

                self.viewModel.updateParticipantData(meetingID: meetingID)

                notificationVM.createOwnerNotification(type: TypeName.vote.rawValue, meetingID: meetingID, ownerID: ownerID)
            }
        }

        delegate?.didtap()

        self.navigationController?.pushViewController(voting, animated: true)
    }

    @IBAction func searchButton(_ sender: Any) {


        guard let text = searchField.text else { return }

        searchStackView.isHidden = false

        if !text.isEmpty {

            notificationVM.fetchOneMeeitngData(meetingID: text)

            let model = notificationVM.meetingViewModels.value

            if !model.isEmpty {

                if text == model[0].meeting.numberForSearch {

                    notificationVM.fetchUserToSelf(userID: model[0].ownerAppleID)

                    notificationVM.meeting = viewModel.meeting

                    notificationVM.onSubjectChanged(model[0].subject ?? "")

                    notificationVM.onNotiMeetingIDAdded(model[0].id)

                    notificationVM.onImageChanged(model[0].image ?? "")

                    guard let subject = model[0].subject as? String else { return }

                    searchResultLabel.text = subject

                } else {

                    goVoteBtnView.isHidden = true

                    searchResultLabel.text = "查無此活動，請重新輸入。"

                }
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
        delegate?.returnToMain()
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