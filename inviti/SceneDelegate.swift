//
//  SceneDelegate.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//
//  swiftlint:disable indentation_width unused_optional_binding vertical_whitespace_opening_braces indentation_width


import UIKit
import FirebaseAuth
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let sceneWindow = (scene as? UIWindowScene) else { return }
//
//        window = UIWindow(windowScene: sceneWindow)
//
//            showMainView(sceneWindow)

        guard let _ = (scene as? UIWindowScene) else { return }
          window?.makeKeyAndVisible()
          if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
           appDelegate.window = window
        }

    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

        if let user = Auth.auth().currentUser {

            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            UserDefaults.standard.setValue(user.uid, forKey: UserDefaults.Keys.uid.rawValue)

            UserDefaults.standard.setValue(user.email, forKey: UserDefaults.Keys.email.rawValue)


            window?.rootViewController = storyboard.instantiateInitialViewController()
            window?.makeKeyAndVisible()

        } else {

            let storyboard = UIStoryboard(name: "Login", bundle: nil)

            window?.rootViewController = storyboard.instantiateInitialViewController()
            window?.makeKeyAndVisible()
        }

    }


    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}
