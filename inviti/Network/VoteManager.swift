//
//  VoteManager.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class VoteManager {

    static let shared = VoteManager()

    lazy var db = Firestore.firestore()

    var userUID = UserDefaults.standard.value(forKey: UserDefaults.Keys.uid.rawValue) as? String ?? ""
    
    func fetchSelectedOptions(optionID: String, meetingID: String, completion: @escaping (Result<[SelectedOption], Error>) -> Void) {
                db.collection("meetings")
                    .document(meetingID)
                    .collection("options")
                    .document(optionID)
                    .collection("selectedOptions")
                    .getDocuments { querySnapshot, error in

                if let error = error {

                    completion(.failure(error))

                } else {

                    var selectedOptions = [SelectedOption]()
                    for document in querySnapshot!.documents {

                        do {
                            if let selectedOption = try document.data(as: SelectedOption.self, decoder: Firestore.Decoder()) {
                                selectedOptions.append(selectedOption)
                            }

                        } catch {

                            completion(.failure(error))

                        }
                    }

                    completion(.success(selectedOptions))
                }
                    }
    }

    func checkIfVoted(meetingID: String, completion: @escaping (Result<[Option], Error>) -> Void) {

            db.collection("meetings")
                .document(meetingID)
                .collection("options")
                .whereField("selectedOptions", arrayContains: userUID)
                .getDocuments { querySnapshot, error in

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

                    }
                }

                completion(.success(options))
            }

        }
    }

    // options
    func checkIfOptionVoted(options: [Option], completion: @escaping (Result<[Option], Error>) -> Void) {

            db.collection("options")
                .whereField("selectedOptions", arrayContains: userUID)
                .getDocuments { querySnapshot, error in

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

                    }
                }

                completion(.success(options))
            }

        }
    }

    func createSelectedOption(selectedOption: inout SelectedOption, meeting: Meeting, option: Option, completion: @escaping (Result<String, Error>) -> Void) {

        let document = db.collection("meetings")
            .document(meeting.id)
            .collection("options")
            .document(option.id)
            .collection("selectedOptions")
            .document()

        selectedOption.id = document.documentID
        selectedOption.selectedUser = userUID as? String

        document.setData(selectedOption.toDict) { error in

            if let error = error {

                completion(.failure(error))

            } else {

                completion(.success(document.documentID))
            }
        }
    }

    func createEmptySelectedOption(selectedOption: inout SelectedOption, meetingID: String, optionID: String, completion: @escaping (Result<String, Error>) -> Void) {

        let document = db.collection("meetings")
            .document(meetingID)
            .collection("options")
            .document(optionID)
            .collection("selectedOptions")
            .document()
            selectedOption.id = document.documentID
            selectedOption.selectedUser = userUID as? String

        document.setData(selectedOption.toDict) { error in

            if let error = error {

                completion(.failure(error))

            } else {

                completion(.success(document.documentID))
            }
        }
    }

    func deleteSelectedOption(selectedOption: SelectedOption, option: Option, meeting: Meeting, completion: @escaping (Result<String, Error>) -> Void) {

        db.collection("meetings")
            .document(meeting.id)
            .collection("options")
            .document(option.id)
            .collection("selectedOptions")
            .document(selectedOption.id).delete() { error in

            if let error = error {

                completion(.failure(error))

            } else {
                print("delete SelectedOption success")
                completion(.success(selectedOption.id))
            }
            }
    }

    func deleteEmptySelectedOption(selectedOptionID: String, optionID: String, meetingID: String, completion: @escaping (Result<String, Error>) -> Void) {

        db.collection("meetings")
            .document(meetingID)
            .collection("options").document(optionID)
            .collection("selectedOptions")
            .document(selectedOptionID)
            .delete() { error in

            if let error = error {

                completion(.failure(error))

            } else {
                print("\(selectedOptionID) has been deleted!")
                completion(.success(selectedOptionID))
            }
        }
    }

//    // Fetch Options & SelectedOptions
//    func fetchVotedData(meetingID: String, completion: @escaping (Result<[Option], Error>) -> Void) {
//
//            db.collection("meetings")
//                .document(meetingID)
//                .collection("options")
//                .getDocuments { querySnapshot, error in
//
//                    if let error = error {
//
//                        completion(.failure(error))
//
//                    } else {
//
//                        var options = [Option]()
//
//                        for document in querySnapshot!.documents {
//
//                            do {
//                                if var option = try document.data(as: Option.self, decoder: Firestore.Decoder()) {
//
//                                self.db.collection("meetings")
//                                    .document(meetingID)
//                                    .collection("options")
//                                    .document("\(option.id)")
//                                    .collection("selectedOptions")
//                                    .getDocuments { querySnapshot, error in
//
//                                        if let error = error {
//
//                                            completion(.failure(error))
//
//                                        } else {
//
//                                            var selectedOptions = [SelectedOption]()
//
//                                            for document in querySnapshot!.documents {
//
//                                                do {
//                                                     if let selectedOption = try document.data(as: SelectedOption.self, decoder: Firestore.Decoder()) {
//
//                                                        selectedOptions.append(selectedOption)
//
//                                                        }
//                                                } catch {
//
//                                                        completion(.failure(error))
//                                                }
//
//                                        }
//                                            option.selectedOptions = selectedOptions
//                                            options.append(option)
//                                            completion(.success(options))
//                                    }
//                                }
//                            }
//
//                            } catch {
//
//                                completion(.failure(error))
//                            }
//                        }
//
//                    }
//                }
//    }
}
