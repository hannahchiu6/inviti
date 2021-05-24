//
//  ProgressHUD.swift
//  inviti
//
//  Created by Hannah.C on 24.05.21.
//

import JGProgressHUD

class ProgressHUD {

    static let shared = ProgressHUD()

    let loadingView: JGProgressHUD = {

        let view = JGProgressHUD(style: .dark)
        view.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        view.textLabel.text = "Loading"
        return view
    }()

    var view: UIView {

        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return UIView() }
        guard let view = appdelegate.window?.rootViewController?.view else {
            return UIView()
        }
        return view
    }

    private init() {}

    static func addLoadingView(at view: UIView?, animated: Bool) {

        guard let view = view else {return}
        ProgressHUD.shared.loadingView.show(in: view, animated: animated)
    }

    static func addLoadingView(animated: Bool = true) {

        ProgressHUD.shared.loadingView.show(in: ProgressHUD.shared.view, animated: animated)
    }

    static func dismissLoadingView(animated: Bool = true) {

        ProgressHUD.shared.loadingView.dismiss(animated: animated)
    }
}
