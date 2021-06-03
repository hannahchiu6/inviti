//
//  EditSuccessVC.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit

class EditSuccessVC: BaseViewController {

    @IBAction func backToMain(_ sender: Any) {

        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let meetingVC = storyboard.instantiateViewController(identifier: "tabBarVC")
        guard let vc = meetingVC as? TabBarViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
