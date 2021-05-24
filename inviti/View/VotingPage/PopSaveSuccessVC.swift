//
//  PopSaveSuccessVC.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit



class PopSaveSuccessVC: BaseViewController {

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

    }

    override func backToRoot(_ sender: Any) {

        backToRoot(completion: {

            let appdelegate = UIApplication.shared.delegate as? AppDelegate

            let root = appdelegate?.window?.rootViewController as? TabBarViewController

            root?.selectedIndex = 0
        })
    }

}
