//
//  File.swift
//  inviti
//
//  Created by Hannah.C on 04.06.21.
//

import Foundation
import JGProgressHUD

class INProgressHUD {

    static let shared = INProgressHUD()

    let loadingView: JGProgressHUD = {

        let view = JGProgressHUD(style: .dark)
        view.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        view.textLabel.text = "Loading"
        return view
    }()

    var view: UIView {

        if var topController = AppDelegate.shared.window?.rootViewController {

            while let presentedViewController = topController.presentedViewController {

                topController = presentedViewController
            }

            return topController.view

            }

           return AppDelegate.shared.window!.rootViewController!.view
    }

    private init() {}

    static func addLoadingView(at view: UIView?, animated: Bool) {

        guard let view = view else { return }
        INProgressHUD.shared.loadingView.show(in: view, animated: animated)
    }

    static func addLoadingView(animated: Bool = true) {

        INProgressHUD.shared.loadingView.show(in: INProgressHUD.shared.view, animated: animated)
    }

    static func dismissLoadingView(animated: Bool = true) {

        INProgressHUD.shared.loadingView.dismiss(animated: animated)
    }


    static func showSuccess(text: String) {

        let hud = JGProgressHUD(style: .dark)

        hud.textLabel.text = text

        hud.show(in: shared.view)

        hud.dismiss(afterDelay: 2.0)

        hud.indicatorView = JGProgressHUDSuccessIndicatorView()

    }

    static func showFailure(text: String) {

        let hud = JGProgressHUD(style: .dark)

        hud.textLabel.text = text

        hud.show(in: shared.view)

        hud.dismiss(afterDelay: 2.0)

        hud.indicatorView = JGProgressHUDErrorIndicatorView()
    }
}
