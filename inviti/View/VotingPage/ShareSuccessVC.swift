//
//  ShareSuccessVC.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit
import JGProgressHUD

class ShareSuccessVC: BaseViewController {
    
    @IBOutlet weak var returnBtnView: UIButton!

//    override func backToRoot(_ sender: Any) {
//
//        backToRoot(completion: {
//
//            let appdelegate = UIApplication.shared.delegate as? AppDelegate
//
//            let root = appdelegate?.window?.rootViewController as? TabBarViewController
//
//            root?.selectedIndex = 0
//        })
//    }

    @IBAction func returnMain(_ sender: Any) {

        print("ShareSuccessVC return button")

//        let storyboard: UIStoryboard = UIStoryboard(name: "Meeting", bundle: nil)
//        let meetingVC = storyboard.instantiateViewController(identifier: "MeetingVC")
//        guard let vc = meetingVC as? MeetingViewController else { return }
//        self.navigationController?.pushViewController(vc, animated: true)

        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let meetingVC = storyboard.instantiateViewController(identifier: "tabBarVC")
        guard let vc = meetingVC as? TabBarViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)

    }

    @IBAction func shareLinkBtn(_ sender: Any) {


        let shareURL = URL(string: "http://www.inviti.tw")
        let items:[Any] = [shareURL as Any]

        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)

        ac.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in

            if completed {


                LKProgressHUD.showSuccess(text: "複製成功")

                return

            } else {
                LKProgressHUD.showFailure()
            }
        }

        present(ac, animated: true, completion: nil)


    }

    var createMeetingViewModel = CreateMeetingViewModel()
 
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
