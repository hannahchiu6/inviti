//
//  AddPeopleViewController.swift
//  inviti
//
//  Created by Hannah.C on 05.06.21.
//

import UIKit

protocol AddPeopleVCDelegate: AnyObject {
    func didtap()
}

class AddPeopleViewController: BaseViewController {

    weak var delegate: AddMeetingVCDelegate?

    var notificationVM = UpdateNotificationVM()

    var viewModel = AddViewModel()

    var meetingID: String?

    var userUID = UserDefaults.standard.value(forKey: "uid")

    @IBOutlet weak var searchField: UITextField! {
        didSet {
            self.searchField.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        notificationVM.fetchOneMeeitngData(meetingID: meetingID ?? "")

    }

    @IBAction func returnButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }

    @IBAction func  sendInviteButton(_ sender: UIButton) {

        let type = TypeName.invite.rawValue

        let participantID = notificationVM.userViewModel.id

        notificationVM.createInviteNotification(type: type, meetingID: meetingID as! String, participantID: participantID as! String)

        viewModel.addSearchParticipants(meetingID: meetingID ?? "", text: participantID)
    }

    @IBAction func goToShare(_ sender: Any) {

        let name = UserDefaults.standard.value(forKey: UserDefaults.Keys.displayName.rawValue) as! String

        let meetingSubject = notificationVM.meetingViewModel.subject

        let message = "您的好友 \(name) 邀請您參加 \(meetingSubject))，來 inviti 票選時間吧！打開 APP 輸入活動 ID 即可參與投票 👉🏻 \(meetingID!)"

       let objectsToShare = [message]

        let ac = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

        ac.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in

            if completed {

                INProgressHUD.showSuccess(text: "發送邀請成功")

            } else {

                INProgressHUD.showFailure(text: "請稍後再試")
            }
        }

        present(ac, animated: true, completion: nil)
    }


    @IBOutlet weak var voteBtnView: UIButton!

}


extension AddPeopleViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {

        guard let text = searchField.text else { return }

        if !text.isEmpty {
            notificationVM.fetchUserData(userID: text)
        }
    }
}
