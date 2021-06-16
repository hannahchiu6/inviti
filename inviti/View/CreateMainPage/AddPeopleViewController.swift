//
//  AddPeopleViewController.swift
//  inviti
//
//  Created by Hannah.C on 05.06.21.
//

import UIKit
import IQKeyboardManagerSwift

class AddPeopleViewController: UIViewController {

    var notificationVM = UpdateNotificationVM()

    var viewModel = AddViewModel()

    var meeting: Meeting?

    var meetingID: String?

    var userUID = UserDefaults.standard.string(forKey: UserDefaults.Keys.uid.rawValue) ?? ""

    @IBOutlet weak var searchField: UITextField! {
        didSet {
            self.searchField.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultView.isHidden = true

        resultPersonImage.layer.cornerRadius = resultPersonImage.bounds.width / 2

        notificationVM.fetchSingleMeeitngData(meetingID: meetingID ?? "")

    }

    // search result stackView
    @IBOutlet weak var searchResultView: UIStackView!

    @IBOutlet weak var resultPersonImage: UIImageView!

    @IBOutlet weak var resultPersonName: UILabel!

    @IBOutlet weak var sendInviteView: UIButton!

    @IBAction func sendInvite(_ sender: Any) {

        let type = TypeName.invite.rawValue

        let participantID = notificationVM.userBox.value.id

        guard let owner = UserDefaults.standard.value(forKey: UserDefaults.Keys.displayName.rawValue) as? String else { return }

        if !notificationVM.meetingViewModels.value.isEmpty {

            let meetingSubject = notificationVM.meetingViewModels.value[0].subject

        if let meetingID = meetingID {

            notificationVM.createInviteNotification(type: type, meetingID: meetingID, participantID: participantID, name: owner, subject: meetingSubject ?? "")

            viewModel.addSearchParticipants(meetingID: meetingID, text: participantID)
            }
        }
    }

    @IBAction func returnButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }

    @IBAction func searchButton(_ sender: UIButton) {

        searchResultView.isHidden = false

        guard let text = searchField.text else { return }

        if !text.isEmpty {

            notificationVM.fetchUserData(userID: text)

            notificationVM.onUserFetched = { [weak self] () in

                if text == self?.notificationVM.userBox.value.numberForSearch {

                self?.resultPersonName.text = self?.notificationVM.userBox.value.name

                self?.sendInviteView.isHidden = false


                if let url = self?.notificationVM.userBox.value.image {

                    self?.notificationVM.onImageChanged(String(url))

                        let imageUrl = URL(string: String(url))

                    self?.resultPersonImage.kf.setImage(with: imageUrl)

                } else {

                    self?.resultPersonImage.image = UIImage(systemName: "person.circle.fill")
                }

            } else {

                self?.resultPersonName.text = "查無此人，請重新輸入。"

                self?.sendInviteView.isHidden = true
            }

            }
        }

    }

    @IBAction func goToShare(_ sender: Any) {

        guard let name = UserDefaults.standard.value(forKey: UserDefaults.Keys.displayName.rawValue) as? String else { return }

        let searchID = notificationVM.meetingViewModels.value[0].numberForSearch

        if !notificationVM.meetingViewModels.value.isEmpty {

            if let meetingSubject = notificationVM.meetingViewModels.value[0].subject {

            let message = "您的好友 \(String(describing: name)) 邀請您參加「\(meetingSubject)」，來 inviti 票選時間吧！打開 APP 輸入活動 ID 即可參與投票 👉🏻 \(searchID)"


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
