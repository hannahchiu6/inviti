//
//  NetworkManager.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

enum FirebaseError: Error {
    case documentError
}

class NetworkManager {

    static let shared = NetworkManager()

    lazy var db = Firestore.firestore()

    var userUID = UserDefaults.standard.string(forKey: UserDefaults.Keys.uid.rawValue) ?? ""

    func randomString(of length: Int) -> String {

        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var results = ""
        for _ in 0 ..< length {
            results.append(letters.randomElement()!)
        }
        return results
    }

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

        db.collection("meetings")
            .document(meetingID)
            .getDocument { document, error in

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

    func fetchSearchResult(meetingID: String, completion: @escaping (Result<Meeting, Error>) -> Void) {

        db.collection("meetings")
            .whereField("numberForSearch", isEqualTo: meetingID)
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
                    if !meetings.isEmpty {

                        completion(.success(meetings[0]))
                    }
                }
            }
    }

    func fetchHostedMeetings(completion: @escaping (Result<[Meeting], Error>) -> Void) {

        db.collection("meetings")
            .whereField("ownerAppleID", isEqualTo: userUID)
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

                      var meeitngs = [Meeting]()

                      for document in querySnapshot!.documents {

                          do {
                              if var meeting = try document.data(as: Meeting.self, decoder: Firestore.Decoder()) {
                                  OptionManager.shared.fetchOptions(meetingID: meeting.id) { result in

                              switch result {

                              case .success(let options):

                                  meeting.options = options
                                  meeitngs.append(meeting)
                                  completion(.success(meeitngs))

                              case .failure(let error):

                                  print("fetchData.failure: \(error)")
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


    func createMeeting(meeting: inout Meeting, completion: @escaping (Result<String, Error>) -> Void) {

        let document = db.collection("meetings").document()
        meeting.id = document.documentID
        meeting.createdTime = Int64(Date().millisecondsSince1970)
        meeting.numberForSearch = self.randomString(of: 6)

        document.setData(meeting.toDict) { error in

            if let error = error {

                completion(.failure(error))
            } else {

                completion(.success("Success"))
            }
        }
    }

    func fetchProfileUser(userIDs: [String], completion: @escaping
                            (Result<[User], Error>) -> Void) {

        for user in userIDs {

            db.collection("users")
                .whereField("id", isEqualTo: user)
                .order(by: "numberForSearch")
                .getDocuments { querySnapshot, error in

                    if let error = error {

                        completion(.failure(error))

                    } else {
                        var users = [User]()

                        for document in querySnapshot!.documents {
                            do {
                                if let user = try document.data(as: User.self, decoder: Firestore.Decoder()) {
                                    users.append(user)
                                }
                            } catch {
                                completion(.failure(error))
                            }
                        }
                        completion(.success(users))

                    }

                }
        }
    }


    func deleteMeeting(meeting: Meeting, completion: @escaping (Result<String, Error>) -> Void) {

        db.collection("meetings")
            .document(meeting.id)
            .delete { error in

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

            docRef.updateData(["subject": "\(subject)", "location": "\(location)", "notes": "\(notes)", "singleMeeting": meeting.singleMeeting, "deadlineTag": meeting.deadlineTag as Any, "deadlineMeeting": meeting.deadlineMeeting, "hiddenMeeting": meeting.hiddenMeeting, "ownerAppleID": userUID]) { err in

                if let err = err {

                    completion(.failure(err))

                } else {

                    completion(.success(meeting))

                }
            }
        }
    }

    func updateMeetingImageURL(meeting: Meeting, completion: @escaping (Result<Meeting, Error>) -> Void) {

        let docRef = db.collection("meetings")
            .document(meeting.id)

        if let url = meeting.image {

            docRef.updateData(["image": "\(url)"]) { err in

                if let err = err {

                    completion(.failure(err))
                } else {

                    completion(.success(meeting))
                }
            }
        }
    }

    func updateMeetingClose(meetingID: String, finalOption: FinalOption) {

        let docRef = db.collection("meetings").document(meetingID)

        docRef.updateData(["isClosed": true, "finalOption": finalOption.toDict]) { err in

            if err != nil {
                print("Error in updating time capsule status")
            } else {
                print("Successfully updated time capsule status!")
            }
        }
    }

    func uploadImage(selectedImage: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let uuid = UUID().uuidString

        guard let image = selectedImage.jpegData(compressionQuality: 0.5) else { return }

        let storageRef = Storage.storage().reference()

        let imageRef = storageRef.child("MeetingImages").child("\(uuid).jpg")

        imageRef.putData(image, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
            }
            if metadata != nil {
                imageRef.downloadURL { url, error in
                    if let url = url {
                        completion(.success(url.absoluteString))
                    } else if let error = error {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
