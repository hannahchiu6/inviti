//
//  ViewController+Extension.swift
//  inviti
//
//  Created by Hannah.C on 23.05.21.
//

import UIKit

extension UIViewController {

    func pop(numberOfTimes: Int) {
        guard let navigationController = navigationController else {
            return
        }
        let viewControllers = navigationController.viewControllers
        let index = numberOfTimes + 1
        if viewControllers.count >= index {
            navigationController.popToViewController(viewControllers[viewControllers.count - index], animated: true)
        }
    }
}
