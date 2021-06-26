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
    
    var userUID = UserDefaults.standard.string(forKey: UserDefaults.Keys.uid.rawValue) ?? ""
    
    func fetchOptions(meetingID: String, completion: @escaping (Result<[Option], Error>) -> Void) {
        db.collection("meetings")
            .document(meetingID)
            .collection("options")
            .order(by: "startTime", descending: false)
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

    func createOption(option: inout Option, meeting: Meeting, completion: @escaping (Result<String, Error>) -> Void) {
        
        let document = db.collection("meetings")
            .document(meeting.id)
            .collection("options")
            .document()
        
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
            .collection("options")
            .document()
        
        option.id = document.documentID
        
        document.setData(option.toDict) { error in
            
            if let error = error {
                
                completion(.failure(error))
                
            } else {
                
                completion(.success(document.documentID))
            }
        }
    }
    
    func updateVotedOption(option: Option, meetingID: String, completion: @escaping (Result<Option, Error>) -> Void) {

        db.collection("meetings")
        .document(meetingID)
        .collection("options")
        .document(option.id)
        .updateData(["selectedOptions": FieldValue.arrayUnion([userUID])]) { err in

            if let err = err {

                completion(.failure(err))

            } else {

                completion(.success(option))

            }
        }
    }
    
    func deleteOption(option: Option, meeting: Meeting, completion: @escaping (Result<String, Error>) -> Void) {
        
        db.collection("meetings")
            .document(meeting.id)
            .collection("options")
            .document(option.id)
            .delete { error in
                
                if let error = error {
                    
                    completion(.failure(error))
                    
                } else {
                    print("delete success")
                    completion(.success(option.id))
                }
            }
    }
    
    func deleteEmptyOption(optionID: String, meetingID: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        db.collection("meetings")
            .document(meetingID)
            .collection("options")
            .document(optionID)
            .delete { error in
                
                if let error = error {
                    
                    completion(.failure(error))
                    
                } else {
                    
                    print("\(optionID) has been deleted!")
                    completion(.success(optionID))
                }
            }
    }
}
