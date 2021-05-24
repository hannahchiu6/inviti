//
//  eventkManager.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class EventManager {

    static let shared = EventManager()

    lazy var db = Firestore.firestore()

    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {

        db.collection("events")
            .order(by: "startTime", descending: true)
            .getDocuments() { querySnapshot, error in

                if let error = error {

                    completion(.failure(error))

                } else {

                    var events = [Event]()

                    for document in querySnapshot!.documents {

                        do {
                            if let event = try document.data(as: Event.self, decoder: Firestore.Decoder()) {
                                events.append(event)
                                print("--------- EventManager ---------")
                                print("\(event.startTime)")

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

        let document = db.collection("events").document()
        event.id = document.documentID
//        event.createdTime = Int64(Date().millisecondsSince1970)
        document.setData(event.toDict) { error in

            if let error = error {

                completion(.failure(error))
            } else {

                completion(.success("Success"))
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
