//
//  NotificationManager.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import JKCalendar


class NotificationManager {

    static let shared = NotificationManager()

    lazy var db = Firestore.firestore()

    var userUID = UserDefaults.standard.value(forKey: "uid")

    func fetchNotifications(completion: @escaping (Result<[Notification], Error>) -> Void) {

        self.db.collection("users")
            .document(self.userUID as! String)
            .collection("notifications")
            .order(by: "createdTime", descending: false)
            .getDocuments { querySnapshot, error in

                if let error = error {

                    completion(.failure(error))

                } else {

                    var notifications = [Notification]()

                    for document in querySnapshot!.documents {

                        do {
                            if let notification = try document.data(as: Notification.self, decoder: Firestore.Decoder()) {
                                notifications.append(notification)
                            }
                        } catch {
                            completion(.failure(error))
                        }
                    }

                    completion(.success(notifications))

                }
            }
    }


    func createNotification(notification: inout Notification, completion: @escaping (Result<String, Error>) -> Void) {

        let document = db.collection("users")
            .document(userUID as! String)
            .collection("notifications")
            .document()
            notification.id = document.documentID
            notification.createdTime = Int64(Date().millisecondsSince1970)
            document.setData(notification.toDict) { error in

            if let error = error {

                completion(.failure(error))

            } else {

                completion(.success(document.documentID))
            }
        }
    }

    
    func createNotificationforOwner(owenerID: String, notification: inout Notification, completion: @escaping (Result<String, Error>) -> Void) {

        let document = db.collection("users")
            .document(owenerID)
            .collection("notifications")
            .document()
            notification.id = document.documentID
            notification.createdTime = Int64(Date().millisecondsSince1970)
            document.setData(notification.toDict) { error in

            if let error = error {

                completion(.failure(error))

            } else {

                completion(.success(document.documentID))
            }
        }
    }

//    func createParticipantsNotification(peopleID: [String], event: inout Event, completion: @escaping (Result<String, Error>) -> Void) {
//
//        for personID in peopleID {
//
//            let document = db.collection("users")
//                .document(personID)
//                .collection("notifications").document()
//                notification.id = document.documentID
//                notification.createdTime = Int64(Date().millisecondsSince1970)
//
//            document.setData(event.toDict) { error in
//
//                if let error = error {
//
//                    completion(.failure(error))
//
//                } else {
//                    completion(.success(document.documentID))
//                }
//            }
//
//        }
//    }

    func deleteEvent(notification: Notification, completion: @escaping (Result<String, Error>) -> Void) {

//        if !UserManager.shared.isLogin() {
//            print("who r u?")
//            return
//        }

//        if let user = meeting.owner {
//            if user.id == "5gWVjg7xTHElu9p6Jkl1"
//                && meeting.category.lowercased() != "test"
//                && !meeting.category.trimmingCharacters(in: .whitespaces).isEmpty
//        {
//                completion(.failure(MasterError.youKnowNothingError("You know nothing!! \(user.id)")))
//                return
//            }
//        }
        let document = db.collection("users")
            .document(userUID as! String)
            .collection("notifications")

            document.document(notification.id).delete() { error in

            if let error = error {

                completion(.failure(error))
                
            } else {

                completion(.success(notification.id))
            }
        }
    }
}
