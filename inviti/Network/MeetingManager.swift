//
//  NetworkManager.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

enum FirebaseError: Error {
    case documentError
}

enum MasterError: Error {
    case getError(String)
}

class NetworkManager {

    static let shared = NetworkManager()

    lazy var db = Firestore.firestore()

    func fetchNewMeetings(completion: @escaping (Result<[Meeting], Error>) -> Void) {

        db.collection("meetings")
            .order(by: "createdTime", descending: true)
            .whereField("createdTime", isGreaterThanOrEqualTo: Date().millisecondsSince1970)
            .getDocuments() { (querySnapshot, error) in

                if let error = error {

                    completion(.failure(error))

                } else {

                    var meetings = [Meeting]()

                    for document in querySnapshot!.documents {

                        do {
                            if let meeting = try document.data(as: Meeting.self, decoder: Firestore.Decoder()) {
                                meetings.append(meeting)
                            }

                        } catch {

                            completion(.failure(error))
//                            completion(.failure(FirebaseError.documentError))
                        }
                    }

                    completion(.success(meetings))
                }
        }
    }

    func fetchOldMeetings(completion: @escaping (Result<[Meeting], Error>) -> Void) {

        db.collection("meetings")
            .order(by: "createdTime", descending: true)
            .whereField("createdTime", isLessThanOrEqualTo: Date().millisecondsSince1970)
            .getDocuments() { (querySnapshot, error) in

                if let error = error {

                    completion(.failure(error))
                    
                } else {

                    var meetings = [Meeting]()

                    for document in querySnapshot!.documents {

                        do {
                            if let meeting = try document.data(as: Meeting.self, decoder: Firestore.Decoder()) {
                                meetings.append(meeting)
                            }

                        } catch {

                            completion(.failure(error))
//                            completion(.failure(FirebaseError.documentError))
                        }
                    }

                    completion(.success(meetings))
                }
        }
    }

    func createMeeting(meeting: inout Meeting, completion: @escaping (Result<String, Error>) -> Void) {

        let document = db.collection("meetings").document()
        meeting.id = document.documentID
        meeting.createdTime = Int64(Date().millisecondsSince1970)
        document.setData(meeting.toDict) { error in

            if let error = error {

                completion(.failure(error))
            } else {

                completion(.success("Success"))
            }
        }
    }

    func deleteMeeting(meeting: Meeting, completion: @escaping (Result<String, Error>) -> Void) {

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

        db.collection("meetings").document(meeting.id).delete() { error in

            if let error = error {

                completion(.failure(error))
                
            } else {

                completion(.success(meeting.id))
            }
        }
    }

    func updateMeeting(meeting: Meeting, completion: @escaping (Result<Meeting, Error>) -> Void) {


        _ = try? db.collection("meetings") .document(meeting.id)
                .setData(from: meeting) { err in

                if let err = err {
                    completion(.failure(err))

                } else {
                    completion(.success(meeting))
                }

         }
    }
}
