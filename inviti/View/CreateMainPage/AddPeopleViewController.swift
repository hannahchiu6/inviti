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

    @IBAction func  sendInviteButton(_ sender: UIButton) {
    }


    @IBAction func goToShare(_ sender: Any) {
        if let name = UserDefaults.standard.value(forKey: UserDefaults.Keys.displayName.rawValue),
           let meetingSubject = createMeetingViewModel.meeting.subject {

        let message = "您的好友 \(name) 邀請您參加 \(String(describing: meetingSubject))，來 inviti 票選時間吧！打開 APP 輸入活動 ID 即可參與投票 👉🏻 \(meetingID!)"
               //Set the link to share.
//               if let link = NSURL(string: "http://yoururl.com") {
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
    }


    @IBOutlet weak var voteBtnView: UIButton!

}


extension AddPeopleViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {

        guard let text = searchField.text else { return }

        if !text.isEmpty {
            viewModel.fetchData(meetingID: text)
        }
    }
}
