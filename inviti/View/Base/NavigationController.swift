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


        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

}
extension UINavigationController {
    func popBackTo(viewcontroller: UIViewController.Type, animated: Bool) {
        for vc in self.viewControllers {
            if vc.isKind(of: viewcontroller) {
                self.popToViewController(vc, animated: animated)
            }
        }
    }
}
