//
//  eventkManager.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import JKCalendar


class EventManager {

    static let shared = EventManager()

    lazy var db = Firestore.firestore()

    var userUID = UserDefaults.standard.value(forKey: "uid")

//    let ownerAppleID: String = UserDefaults.standard.value(forKey: UserDefaults.Keys.uid.rawValue) as! String

    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {

        db.collection("events")
            .order(by: "date", descending: false)
            .getDocuments { querySnapshot, error in

                if let error = error {

                    completion(.failure(error))

                } else {

                    var events = [Event]()

                    for document in querySnapshot!.documents {

                        do {
                            if let event = try document.data(as: Event.self, decoder: Firestore.Decoder()) {
                                events.append(event)

                            }

                        } catch {

                            completion(.failure(error))
                        }
                    }

                    completion(.success(events))
                }
        }
    }

//    func fetchOwnerEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
//
//        db.collection("events")
//            .whereField("ownerAppleID", isEqualTo: userUID as! String)
//            .getDocuments { querySnapshot, error in
//
//                if let error = error {
//
//                    completion(.failure(error))
//
//                } else {
//
//                    var events = [Event]()
//
//                    for document in querySnapshot!.documents {
//
//                        do {
//                            if let event = try document.data(as: Event.self, decoder: Firestore.Decoder()) {
//                                events.append(event)
//
//                            }
//
//                        } catch {
//
//                            completion(.failure(error))
//                        }
//                    }
//
//                    completion(.success(events))
//                }
//        }
//    }

    // User 下面的 subcollection
    func fetchSubEvents(completion: @escaping (Result<[Event], Error>) -> Void) {

        self.db.collection("users")
            .document(self.userUID as! String)
            .collection("events")
            .order(by: "startTime", descending: false)
            .getDocuments { querySnapshot, error in

                if let error = error {

                    completion(.failure(error))

                } else {

                    var events = [Event]()

                    for document in querySnapshot!.documents {

                        do {
                            if let event = try document.data(as: Event.self, decoder: Firestore.Decoder()) {
                                events.append(event)
                            }
                        } catch {
                            completion(.failure(error))
                        }
                    }

                    completion(.success(events))

                }
            }
    }


    func createEvent(event: inout Event, completion: @escaping (Result<String, Error>) -> Void) {

        let document = db.collection("users")
            .document(userUID as! String)
            .collection("events")
            .document()
            event.id = document.documentID

        document.setData(event.toDict) { error in

            if let error = error {

                completion(.failure(error))

            } else {

                completion(.success(document.documentID))
            }
        }
    }

    func createParticipantsEvent(peopleID: [String], event: inout Event, completion: @escaping (Result<String, Error>) -> Void) {

        for personID in peopleID {

            let document = db.collection("users")
                .document(personID)
                .collection("events").document()
                event.id = document.documentID

            document.setData(event.toDict) { error in

                if let error = error {

                    completion(.failure(error))

                } else {
                    completion(.success(document.documentID))
                }
            }

        }
    }

    func deleteEvent(event: Event, completion: @escaping (Result<String, Error>) -> Void) {

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

        db.collection("events").document(event.id).delete() { error in

            if let error = error {

                completion(.failure(error))
                
            } else {

                completion(.success(event.id))
            }
        }
    }
}
