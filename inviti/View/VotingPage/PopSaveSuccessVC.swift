//
//  PopSaveSuccessVC.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit

protocol PopSaveSuccessDelegate {
    func didTap()
}
class PopSaveSuccessVC: UIViewController {

//    var delegate: PopSaveSuccessDelegate?

    @IBAction func returnMain(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Meeting", bundle: nil)
        let meetingVC = storyboard.instantiateViewController(identifier: "MeetingVC")
           guard let vc = meetingVC as? MeetingViewController else { return }

//        guard let indexPath = self.tableView.indexPath(for: sender) else { return }
//
//        edit.meetingInfo = sender.meetings

//        delegate?.didTap()
//        self.dismiss(animated: true, completion: nil)
//        navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(vc, animated: true)

        
        print("PopSaveSuccessVC?!!!!")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false

    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
