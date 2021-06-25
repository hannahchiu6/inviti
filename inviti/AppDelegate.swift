//
//  AppDelegate.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.


import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import IQKeyboardManagerSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // swiftlint:disable force_cast
    static let shared = UIApplication.shared.delegate as! AppDelegate
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        
        if UserDefaults.standard.value(forKey: "logInOrNot") != nil && UserDefaults.standard.value(forKey: "currentUserData") != nil {
            
            toNextpage()
            
        } else {
            
            UserDefaults.standard.set(true, forKey: "logInOrNot")
            UserDefaults.standard.set(true, forKey: "currentUserData")
            UserDefaults.standard.set(nil, forKey: "email")
            UserDefaults.standard.set(nil, forKey: "userName")
            UserDefaults.standard.set(nil, forKey: "userPhoto")
            UserDefaults.standard.set(nil, forKey: "userID")
            
            let viewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(identifier: "LoginVC") as? LoginViewController
            
            window?.rootViewController = viewController
            
            window?.makeKeyAndVisible()
        }
        
        if #available(iOS 13, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        return true
        
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    @objc func toNextpage() {
        
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBarVC") as? UITabBarController else {
            return
        }
        
        window?.rootViewController = viewController
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

}
