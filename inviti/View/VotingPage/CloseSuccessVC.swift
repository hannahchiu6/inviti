//
//  CloseSuccessVC.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit
import JGProgressHUD

class CloseSuccessVC: BaseViewController {
    
    @IBOutlet weak var returnBtnView: UIButton!

    @IBAction func returnCalendar(_ sender: Any) {

        print("CloseSuccessVC return button")

        let storyboard: UIStoryboard = UIStoryboard(name: "Calendar", bundle: nil)
        let calendarVC = storyboard.instantiateViewController(identifier: "TabCalendarVC")
        guard let vc = calendarVC as? TabCalendarViewController else { return }
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
 
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
