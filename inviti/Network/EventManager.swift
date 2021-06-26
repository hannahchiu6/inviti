//
//  EventkManager.swift
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
    
    var userUID = UserDefaults.standard.string(forKey: UserDefaults.Keys.uid.rawValue) ?? ""
    
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
    
    // User 下面的 subcollection
    func fetchSubEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        
        self.db.collection("users")
            .document(self.userUID)
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
            .document(userUID)
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
    }
    
    func deleteEvent(eventID: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        db.collection("users")
            .document(userUID)
            .collection("events")
            .document(eventID)
            .delete { error in
                
                if let error = error {
                    
                    completion(.failure(error))
                    
                } else {
                    
                    completion(.success(eventID))
                    print("\(eventID) has been deleted!")
                }
            }
    }
}
