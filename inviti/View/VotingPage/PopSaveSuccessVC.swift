//
//  PopSaveSuccessVC.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit

//protocol PopSaveSuccessDelegate {
//    func didTap()
//}

class PopSaveSuccessVC: UIViewController {

//    var delegate: PopSaveSuccessDelegate?

    @IBAction func returnMain(_ sender: Any) {


//        performSegue(withIdentifier: "backToMainSegue", sender: self)
        dismiss(animated: true, completion: nil)

//        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

    }

//        let storyboard: UIStoryboard = UIStoryboard.meeting
//        let vc = (storyboard.instantiateViewController(identifier: "MeetingVC") as? MeetingViewController)!
//        if let firstVC = navigationController?.viewControllers[0] {
//                    navigationController?.popToViewController(firstVC, animated: true)
//        }
//        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//        pop(numberOfTimes: 1)
//        dismiss(animated: true, completion: nil)
//        self.navigationController?.popToRootViewController(animated: true)

//        let storyboard: UIStoryboard = UIStoryboard.meeting
//        let editVC = storyboard.instantiateViewController(identifier: "MeetingVC")
//           guard let edit = editVC as? MeetingViewController else { return }

//        navigationController?.pushViewController(vc, animated: true)
//        navigationController?.popToViewController(vc, animated: true)
      
//        pushViewController(edit, animated: true)

    @IBOutlet weak var successView: UIView!
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

//        self.presentingViewController?.dismiss(animated: false, completion: nil)
        // Hide the navigation bar on the this view controller
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//        self.tabBarController?.tabBar.isHidden = false
//       view.backgroundColor = UIColor.clear

    }
    override func viewDidLoad() {
        super.viewDidLoad()

//        let blurEffect = UIBlurEffect(style: .regular)
//           let blurEffectView = UIVisualEffectView(effect: blurEffect)
//           blurEffectView.frame = view.bounds
//           blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//           self.view.addSubview(blurEffectView)
//        self.view.bringSubviewToFront(self.successView)
//
    }

}
