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
    
    var userUID = UserDefaults.standard.string(forKey: UserDefaults.Keys.uid.rawValue) ?? ""

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
    

    func deleteEmptySelectedOption(selectedOptionID: String, optionID: String, meetingID: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        db.collection("meetings")
            .document(meetingID)
            .collection("options")
            .document(optionID)
            .collection("selectedOptions")
            .document(selectedOptionID)
            .delete { error in
                
                if let error = error {
                    
                    completion(.failure(error))
                    
                } else {
                    print("\(selectedOptionID) has been deleted!")
                    completion(.success(selectedOptionID))
                }
            }
    }
}
