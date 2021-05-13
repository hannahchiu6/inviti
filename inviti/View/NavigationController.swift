//
//  NavigationController.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        let rightButton = UIBarButtonItem(image: UIImage(named: "NotificationBell.png"), style: .plain, target: nil, action: nil)
        rightButton.tintColor = UIColor(red: 1, green: 0.3647, blue: 0, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = rightButton
    }



}
