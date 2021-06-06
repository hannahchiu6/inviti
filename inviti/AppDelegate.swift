//
//  AppDelegate.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
// swiftlint:disable multiline_parameters_brackets


import UIKit
import Firebase
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

//    func addToDatabase() {
//
//        guard let userID = Auth.auth().currentUser?.uid,
//            let userEmail = Auth.auth().currentUser?.providerData.first?.email,
//            let userName = Auth.auth().currentUser?.providerData.first?.displayName,
//            let userPhoto = Auth.auth().currentUser?.providerData.first?.photoURL?.absoluteString else {
//                return
//        }

//        var userPhotoString = ""
//
//        let size = "?width=400&height=400"
//
//        let userPicture = "\(userPhoto + size)"

//        guard let googlelPhoto = URL(string: userPicture) else {
//            return
//        }

//        let group = DispatchGroup()
//        group.enter()

//        getData(from: googlelPhoto) { (data, _, error) in
//
//            guard let data = data else {
//                return
//            }
//
//            guard let image = UIImage(data: data) else {
//                return
//            }
//
//            guard let photo = image.jpegData(compressionQuality: 0.5) else {
//                return
//            }
//
//            let storageRef = Storage.storage().reference().child("UserPhoto").child("\(userID).jpeg")
//
//            storageRef.putData(photo, metadata: nil) { (_, error) in
//
//                if error != nil {
//                    print("To Storage Failed")
//                    return
//                }
//                storageRef.downloadURL { (url, error) in
//
//                    if error != nil {
//                        print("Get URL Failed")
//                        return
//                    }
//
//                    guard let backUserPhoto = url?.absoluteString else {
//                        return
//                    }
//                    userPhotoString = backUserPhoto
//                    group.leave()
//                }

//                let usersData = User(name: userName, email: userEmail, appleID: userID)
//
//                Firestore.firestore()
//                    .collection("users")
//                    .document(userID)
//                    .setData(usersData.toDict, completion: { (error) in
//                    if error == nil {
//
//                        UserDefaults.standard.set(true, forKey: "logInOrNot")
//                        UserDefaults.standard.set(true, forKey: "currentUserData")
//                        UserDefaults.standard.set(userEmail, forKey: "email")
//                        UserDefaults.standard.set(userName, forKey: "userName")
//                        UserDefaults.standard.set(userPhotoString, forKey: "userPhoto")
//                        UserDefaults.standard.set(userID, forKey: "userID")
//
//
//                        print("DB added successfully")
//
//                        self.toNextpage()
//
//                    } else {
//                        print("Added failed")
//                    }
//                })
//            }
//        }


}
