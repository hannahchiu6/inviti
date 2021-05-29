//
//  OptionManager.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class OptionManager {

    static let shared = OptionManager()

    lazy var db = Firestore.firestore()

    func fetchOptions(meetingID: String, completion: @escaping (Result<[Option], Error>) -> Void) {
        let docfef = db.collection("meetings")
                    .document(meetingID)
                    .collection("options")
                    .order(by: "startTime", descending: false)
                    .getDocuments() { (querySnapshot, error) in

                if let error = error {

                    completion(.failure(error))

                } else {

                    var options = [Option]()
                    for document in querySnapshot!.documents {

                        do {
                            if let option = try document.data(as: Option.self, decoder: Firestore.Decoder()) {
                                options.append(option)
                            }

                        } catch {

                            completion(.failure(error))
//                            completion(.failure(FirebaseError.documentError))
                        }
                    }

                    completion(.success(options))
                }
        }
    }


    func createOption(option: inout Option, meeting: Meeting, completion: @escaping (Result<String, Error>) -> Void) {

        let document = db.collection("meetings")
            .document(meeting.id)
            .collection("options").document()
            option.id = document.documentID

        document.setData(option.toDict) { error in

            if let error = error {

                completion(.failure(error))
                
            } else {

                completion(.success(document.documentID))
            }
        }
    }

    func createEmptyOption(option: inout Option, meetingID: String, completion: @escaping (Result<String, Error>) -> Void) {

        let document = db.collection("meetings")
            .document(meetingID)
            .collection("options").document()
            option.id = document.documentID

        document.setData(option.toDict) { error in

            if let error = error {

                completion(.failure(error))

            } else {

                completion(.success(document.documentID))
            }
        }
    }

    func deleteOption(option: Option, meeting: Meeting, completion: @escaping (Result<String, Error>) -> Void) {

        db.collection("meetings").document(meeting.id).collection("options").document(option.id).delete() { error in

            if let error = error {

                completion(.failure(error))

            } else {
                print("delete success")
                completion(.success(option.id))
            }
        }
    }

    func deleteEmptyOption(optionID: String, meetingID: String, completion: @escaping (Result<String, Error>) -> Void) {

        db.collection("meetings").document(meetingID).collection("options").document(optionID).delete() { error in

            if let error = error {

                completion(.failure(error))

            } else {
                print("\(optionID) has been deleted!")
                completion(.success(optionID))
            }
        }
    }
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


}
