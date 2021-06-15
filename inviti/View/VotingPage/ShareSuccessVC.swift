//
//  ShareSuccessVC.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit

class ShareSuccessVC: BaseViewController {
    
    @IBOutlet weak var returnBtnView: UIButton!

    var meetingID: String!

    var meetingSubject: String?

    var viewModel = CreateMeetingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.onSubjectAdded = { [weak self] subject in

            self?.meetingSubject = subject
        }
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//
//        createMeetingViewModel.fetchOneMeeitngData(meetingID: meetingID)
//
//        meetingSubject = createMeetingViewModel.meetingViewModels.value[0].subject
//
//    }


    @IBAction func returnMain(_ sender: UIButton) {

//        let storyboard: UIStoryboard = UIStoryboard(name: "Meeting", bundle: nil)
//        let meetingVC = storyboard.instantiateViewController(identifier: "MeetingVC")
//        guard let vc = meetingVC as? MeetingViewController else { return }
//        self.navigationController?.pushViewController(vc, animated: true)

        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let meetingVC = storyboard.instantiateViewController(identifier: "TabBarVC")
        guard let vc = meetingVC as? TabBarViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)

    }

    @IBAction func shareLinkBtn(_ sender: Any) {

        if let name = UserDefaults.standard.value(forKey: UserDefaults.Keys.displayName.rawValue),
           let subject = meetingSubject,
           let searchID = viewModel.meeting.numberForSearch as? String {

            let message = "您的好友 \(name) 邀請您參加 \(subject)，來 inviti 票選時間吧！打開 APP 輸入活動 ID 即可參與投票 👉🏻 \(searchID)"

               //Set the link to share.
//               if let link = NSURL(string: "http://yoururl.com") {

        let objectsToShare = [message]

        let ac = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

        ac.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in

            if completed {

                INProgressHUD.showSuccess(text: "發送邀請成功")
                return

            } else {

                INProgressHUD.showFailure(text: "請稍後再試")
            }
        }

        present(ac, animated: true, completion: nil)

        }
    }

}
