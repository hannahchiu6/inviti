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




enum HUDType {

    case success(String)

    case failure(String)
}

class LKProgressHUD {

    static let shared = LKProgressHUD()

    private init() { }

    let hud = JGProgressHUD(style: .dark)

    var view: UIView {

        return AppDelegate.shared.window!.rootViewController!.view
    }

    static func show(type: HUDType) {

        switch type {

        case .success(let text):

            showSuccess(text: text)

        case .failure(let text):

            showFailure(text: text)
        }
    }

    static func showSuccess(text: String = "success") {

        if !Thread.isMainThread {

            DispatchQueue.main.async {
                showSuccess(text: text)
            }

            return
        }

        shared.hud.textLabel.text = text

        shared.hud.indicatorView = JGProgressHUDSuccessIndicatorView()

        shared.hud.show(in: shared.view)

        shared.hud.dismiss(afterDelay: 1.5)
    }

    static func showFailure(text: String = "Failure") {

        if !Thread.isMainThread {

            DispatchQueue.main.async {
                showFailure(text: text)
            }

            return
        }

        shared.hud.textLabel.text = text

        shared.hud.indicatorView = JGProgressHUDErrorIndicatorView()

        shared.hud.show(in: shared.view)

        shared.hud.dismiss(afterDelay: 1.5)
    }

    static func show() {

        if !Thread.isMainThread {

            DispatchQueue.main.async {
                show()
            }

            return
        }

        shared.hud.indicatorView = JGProgressHUDIndeterminateIndicatorView()

        shared.hud.textLabel.text = "Loading"

        shared.hud.show(in: shared.view)
    }

    static func dismiss() {

        if !Thread.isMainThread {

            DispatchQueue.main.async {
                dismiss()
            }

            return
        }

        shared.hud.dismiss()
    }
}
