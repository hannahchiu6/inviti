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

    var userUID = UserDefaults.standard.value(forKey: "uid") as? String ?? ""

    var number = Int.random(in: 0...9)

    var user = User(id: "", email: "", name: "inviti User", image: "", phone: "", address: "", calendarType: "", numOfMeetings: 0, numberForSearch: "")

    func randomString(of length: Int) -> String {

        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var results = ""
        for _ in 0 ..< length {
            results.append(letters.randomElement()!)
        }
        return results
    }

    func updateUserData(user: User, completion: @escaping (Result<String, Error>) -> Void) {
        do {

            try db.collection("users")
                .document(userUID)
                .setData(from: user)

            completion(.success("Successfully updated user data!"))

        } catch {
            
            completion(.failure(error))
        }
    }

    func createUser(user: inout User, completion: @escaping (Result<String, Error>) -> Void) {

        let document = db.collection("users").document(userUID)

        user.id = userUID
        user.numberForSearch = self.randomString(of: 6)

        document.setData(user.toDict) { error in

            if let error = error {

                completion(.failure(error))
                
            } else {

                completion(.success("Success"))

            }
        }
    }


    func createNewUser(completion: @escaping (Result<String, Error>) -> Void) {


        let document = db.collection("users").document(userUID)
        user.id = userUID
        user.numberForSearch = self.randomString(of: 6)

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
        let docRef = db.collection("users").whereField("appleID", isEqualTo: userUID)

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


    func fetchProfileUser(completion: @escaping
                    (Result<User, Error>) -> Void) {

        let docRef = db.collection("users")
            .document(userUID)

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


    func fetchOneUser(userID: String, completion: @escaping
                    (Result<User, Error>) -> Void) {
       db.collection("users")
        .whereField("numberForSearch", isEqualTo: userID)
        .getDocuments { querySnapshot, error in

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
                        if !users.isEmpty {
                            completion(.success(users[0]))

                        }
                }
                    }
            }


    func didLoginBefore (completion: @escaping
                    (Result<[User], Error>) -> Void) {
       db.collection("users")
            .whereField("id", isEqualTo: userUID)
            .getDocuments { querySnapshot, error in

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

    func uploadImage(selectedImage: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
            let uuid = UUID().uuidString

            guard let image = selectedImage.jpegData(compressionQuality: 0.5) else { return }

            let storageRef = Storage.storage().reference()

            let imageRef = storageRef.child("ProfileImages").child("\(uuid).jpg")

            imageRef.putData(image, metadata: nil) { metadata, error in
             if let error = error {
              completion(.failure(error))
             }
             guard let _ = metadata else { return }

             imageRef.downloadURL { url, error in
                
              if let url = url {
               completion(.success(url.absoluteString))
              } else if let error = error {
               completion(.failure(error))
              }

             }

            }

    }

    func updateUserImageURL(url: String, completion: @escaping (Result<String, Error>) -> Void) {

        let docRef =
            db.collection("users")
            .document(userUID)

        if let url = url as? String {

            docRef.updateData([
                "image": "\(url)"
            ]) { err in
                if let err = err {

                    completion(.failure(err))

                } else {

                    completion(.success(url))

                }
            }
        }
    }
    func updateUserDetails(user: User, completion: @escaping (Result<User, Error>) -> Void) {

        let docRef = db.collection("users").document(userUID)

        if let name = user.name as? String,
           let email = user.email as? String,
            let image = user.image as? String {

            docRef.updateData([
                "name": "\(name)",
                "email": "\(email)",
                "image": "\(image)"

            ]) { err in

                if let err = err {

                    completion(.failure(err))

                } else {

                    completion(.success(user))

                }
            }
        }
    }


    func updateUserName(name: String) {
        db.collection("users")
            .document(userUID)
            .updateData([name: name]) { err in

            if let err = err {

                print("Failed to update user name")
            } else {
                print("User name has been updated!")
            }
        }
    }

    func updateUserEmail(email: String) {
        db.collection("users")
            .document(userUID)
            .updateData([email: email]) { err in

            if let err = err {
                
                print("Failed to update user email")
            } else {
                print("User email has been updated!")
            }
        }
    }

    func isLogin() -> Bool {
        return user != nil
    }
}
