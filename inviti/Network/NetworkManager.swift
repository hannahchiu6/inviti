//
//  NetworkManager.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//
//  swiftlint:disable force_unwrapping inclusive_language closure_end_indentation

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

    var userUID = UserDefaults.standard.value(forKey: "uid")

    func fetchMeetings(completion: @escaping (Result<[Meeting], Error>) -> Void) {

        db.collection("meetings")
            .getDocuments { querySnapshot, error in

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
                        }
                    }

                    completion(.success(meetings))
                }
            }
    }

    func fetchOneMeeting(meetingID: String, completion: @escaping (Result<Meeting, Error>) -> Void) {

        let docRef = db.collection("meetings").document(meetingID)
            docRef.getDocument { document, error in

        let result = Result {
          try document?.data(as: Meeting.self)
        }

            switch result {

            case .success(let meeting):
                if let meeting = meeting {

                    completion(.success(meeting))

                } else {

                    print("Document does not exist")

                }
            case .failure(let error):

                print("Error decoding city: \(error)")

                completion(.failure(error))
            }
        }
    }


    func fetchHostedMeetings(completion: @escaping (Result<[Meeting], Error>) -> Void) {

       let docRef = db.collection("meetings")
            .whereField("ownerAppleID", isEqualTo: userUID)
//            .order(by: "createdTime", descending: true)
            .getDocuments { querySnapshot, error in

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
                        }
                    }

                    completion(.success(meetings))
                }
            }
    }

    func fetchParticipatedMeetings(completion: @escaping (Result<[Meeting], Error>) -> Void) {

        db.collection("meetings")
            .whereField("participants", arrayContains: userUID)
            .getDocuments { querySnapshot, error in

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

        db.collection("meetings").document(meeting.id).delete() { error in

            if let error = error {

                completion(.failure(error))
                
            } else {

                completion(.success(meeting.id))
            }
        }
    }

    func deleteOneMeeting(meetingID: String, completion: @escaping (Result<String, Error>) -> Void) {

        db.collection("meetings")
            .document(meetingID)
            .delete { error in

            if let error = error {

                completion(.failure(error))

            } else {

                completion(.success(meetingID))
            }
        }
    }

    func updateMeeting(meetingID: String, meeting: Meeting, completion: @escaping (Result<Meeting, Error>) -> Void) {

        let docRef = db.collection("meetings").document(meetingID)

        if let subject = meeting.subject,
           let location = meeting.location,
           let notes = meeting.notes {

            docRef.updateData([
                "subject": "\(subject)",
                "location": "\(location)",
                "notes": "\(notes)",
                "singleMeeting": meeting.singleMeeting,
                "deadlinTag": meeting.deadlineTag as Any,
                "deadlineMeeting": meeting.deadlineMeeting,
                "hiddenMeeting": meeting.hiddenMeeting

            ]) { err in

                if let err = err {

                    completion(.failure(err))

                } else {

                    completion(.success(meeting))

                }
            }
        }
    }


    // Fetch Meetings & Options
    func fetchMeetingsPackage(completion: @escaping (Result<[Meeting], Error>) -> Void) {
       db.collection("meetings")
        //   .order(by: “name “)
   //     .whereField(“teachers”, arrayContains: UserManager.shared.userID!)
        .getDocuments { querySnapshot, error in

         if let error = error {

            completion(.failure(error))
         } else {

            var meeitngs = [Meeting]()

            for document in querySnapshot!.documents {

                do {
                    if var meeting = try document.data(as: Meeting.self, decoder: Firestore.Decoder()) {
                        self.db.collection("meetings")
                            .document("\(meeting.id)")
                            .collection("options")
   //           .order(by: “number”, descending: false)
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

                                    meeting.options = options
                                    meeitngs.append(meeting)
                                    completion(.success(meeitngs))

                                }
                            }
                    }
                } catch {

                    completion(.failure(error))
                }
            }
          }
        }
    }

    // Fetch Meetings & Options & SelectedOptions
    func fetchFullPackage(completion: @escaping (Result<[Meeting], Error>) -> Void) {
       db.collection("meetings")
        //   .order(by: “name “)
   //     .whereField(“teachers”, arrayContains: UserManager.shared.userID!)
        .getDocuments { querySnapshot, error in

         if let error = error {

            completion(.failure(error))

         } else {

            var meeitngs = [Meeting]()

            for document in querySnapshot!.documents {

                do {
                        if var meeting = try document.data(as: Meeting.self, decoder: Firestore.Decoder()) {

                        self.db.collection("meetings")
                            .document("\(meeting.id)")
                            .collection("options")
   //           .order(by: “number”, descending: false)
                            .getDocuments { querySnapshot, error in

                                if let error = error {

                                    completion(.failure(error))

                                } else {

                                    var options = [Option]()

                                    for document in querySnapshot!.documents {

                                        do {
                                            if var option = try document.data(as: Option.self, decoder: Firestore.Decoder()) {

                                            self.db.collection("meetings")
                                                .document("\(meeting.id)")
                                                .collection("options")
                                                .document("\(option.id)")
                                                .collection("selectedOptions")
                       //           .order(by: “number”, descending: false)
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
                                                        option.selectedOptions = selectedOptions
                                                        options.append(option)
                                                }


                                            }

                                        }

                                        } catch {

                                            completion(.failure(error))
                                        }
                                    }

                                    meeting.options = options
                                    meeitngs.append(meeting)
                                    completion(.success(meeitngs))

                                }
                            }
                    }
                } catch {

                    completion(.failure(error))
                }
            }
          }
        }
    }

}
