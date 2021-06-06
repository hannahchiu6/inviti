//
//  UserManager.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

enum LoginError: Error {
    case idNotExistError(String)
}

class UserManager {

    static let shared = UserManager()

    lazy var db = Firestore.firestore()

    var userUID = UserDefaults.standard.value(forKey: "uid")

    var user = User(id: "", email: "", name: "inviti User", image: "", phone: "", address: "", calendarType: "", numOfMeetings: 0)

    func updateUserData(user: User, completion: @escaping (Result<String, Error>) -> Void) {
        do {

            try db.collection("users")
                .document(userUID as! String)
                .setData(from: user)

            completion(.success("Successfully updated user data!"))

        } catch {
            
            completion(.failure(error))
        }
    }

    func createUser(user: inout User, completion: @escaping (Result<String, Error>) -> Void) {

        let document = db.collection("users").document(userUID as! String)
//        document.documentID = userUID as! String
        user.id = userUID as! String

        document.setData(user.toDict) { error in

            if let error = error {

                completion(.failure(error))
                
            } else {

                completion(.success("Success"))

            }
        }
    }


    func createNewUser(completion: @escaping (Result<String, Error>) -> Void) {


        let document = db.collection("users").document(userUID as! String)
        user.id = userUID as! String

        document.setData(user.toDict) { error in

            if let error = error {

                completion(.failure(error))

            } else {

                completion(.success("Success"))

            }
        }
    }

//        let document = db.collection("users").document()
//        user.id = document.documentID
//        user.appleID = self.user.appleID
//        user.email = self.user.email
//        document.setData(user.toDict) { error in
//
//            if let error = error {
//
//                completion(.failure(error))
//
//            } else {
//
//                completion(.success("Success"))
//
//            }
//        }
    

    func fetchUser(user: User, completion: @escaping
                    (Result<User, Error>) -> Void) {
        let docRef = db.collection("users").whereField("appleID", isEqualTo: userUID as! String)

        docRef.getDocuments { querySnapshot, error in

            if let error = error {

                completion(.failure(error))

            } else {

                var users = [User]()

                for document in querySnapshot!.documents {

                    do {
                        if let user = try document.data(as: User.self, decoder: Firestore.Decoder()) {
                            users.append(user)
                        }

                    } catch {

                        completion(.failure(error))
                    }
                }

                completion(.success(users[0]))
            }
        }
    }

    func fetchOneUser(userID: String, completion: @escaping
                    (Result<User, Error>) -> Void) {
        let docRef = db.collection("users")
            .document(userID)

        docRef.getDocument { document, error in

            let result = Result {
              try document?.data(as: User.self)
            }

                switch result {

                case .success(let user):
                    if let user = user {

                        completion(.success(user))

                    } else {

                        print("User does not exist")

                    }
                case .failure(let error):

                    print("Error decoding city: \(error)")

                    completion(.failure(error))
                }
            }
        }

    func didLoginBefore (completion: @escaping
                    (Result<[User], Error>) -> Void) {
        let docRef = db.collection("users")
            .whereField("id", isEqualTo: userUID as! String)

        docRef.getDocuments { querySnapshot, error in

            if let error = error {

                completion(.failure(error))

            } else {

                var users = [User]()

                for document in querySnapshot!.documents {

                    do {
                        if let user = try document.data(as: User.self, decoder: Firestore.Decoder()) {
                            users.append(user)
                        }

                    } catch {

                        completion(.failure(error))
                    }
                }

                completion(.success(users))
            }
        }
    }


    func updateUserName(name: String) {
        db.collection("users")
            .document(self.user.id ?? "")
            .updateData([name: name]) { err in
            if let err = err {
                print("Failed to update user name")
            } else {
                print("User name has been updated!")
            }
        }
    }

    func updateImage(image: String) {
        db.collection("users")
            .document(self.user.id ?? "")
            .updateData([image: image]) { err in
            if let err = err {
                print("Failed to update user profile image")
            } else {
                print("User profile image has been updated!")
            }
        }
    }

    func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let timeStamp = Date().timeIntervalSince1970
        let storageRef = Storage.storage().reference().child("\(self.user.id ?? "")profileImage.png")
        guard let imageData = image.pngData() else {
            print("Can't convert to png data.")
            return
        }

        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Failed to upload image to Firebase.")
                completion(.failure(error))
            } else {
                let url = storageRef.downloadURL(completion: { url, error in
                    guard let downloadURL = url else {
                        print("Can't convert to url")
                        return
                    }
                    self.updateImage(image: downloadURL.absoluteString)
                    completion(.success(downloadURL.absoluteString))
                })
            }
        }
    }


    func isLogin() -> Bool {
        return user != nil
    }
}

class SimpleManager {

    static let shared = SimpleManager()

    var user: SimpleUser?

    func login(id: String = "", completion: @escaping (Result<SimpleUser, Error>) -> Void) {

        switch id {
        case "moon2021":
            user = SimpleUser(id: "", email: "moon2021@gmail.com", image: "")

            completion(.success(user!))

        // MARK: add your profile here
        default:
            completion(.failure(LoginError.idNotExistError("You have to add \(id) info in local data source")))
        }
    }

    func isLogin() -> Bool {
        return user != nil
    }
}
