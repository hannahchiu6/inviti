////
////  OptionManager.swift
////  inviti
////
////  Created by Hannah.C on 20.05.21.
////
//
//import Foundation
//import Firebase
//import FirebaseFirestoreSwift
//
//
//class SelectedDataManager {
//
//    static let shared = SelectedDataManager()
//
//    lazy var db = Firestore.firestore()
//
//    func fetchSelectedData(selectedData: SelectedData, completion: @escaping (Result<[SelectedData], Error>) -> Void) {
//        let docfef = db.collection("selectedData")
//                    .order(by: "startTime", descending: false)
//                    .getDocuments() { (querySnapshot, error) in
//
//                if let error = error {
//
//                    completion(.failure(error))
//
//                } else {
//
//                    var selectedDatas = [SelectedData]()
//                    for document in querySnapshot!.documents {
//
//                        do {
//                            if let selectedData = try document.data(as: SelectedData.self, decoder: Firestore.Decoder()) {
//                                selectedDatas.append(selectedData)
//                            }
//
//                        } catch {
//
//                            completion(.failure(error))
//
//                        }
//                    }
//
//                    completion(.success(selectedDatas))
//                }
//        }
//    }
//
//
//    func createSelectedData(selectedData: inout SelectedData, completion: @escaping (Result<String, Error>) -> Void) {
//
//        let document = db.collection("selectedData")
//            .document(selectedData.id)
//        selectedData.id = document.documentID
//
//        document.setData(selectedData.toDict) { error in
//
//            if let error = error {
//
//                completion(.failure(error))
//                
//            } else {
//
//                completion(.success(document.documentID))
//            }
//        }
//    }
//
//    func deleteSelectedData(selectedData: SelectedData, completion: @escaping (Result<String, Error>) -> Void) {
//
//        db.collection("selectedData").document(selectedData.id).delete() { error in
//
//            if let error = error {
//
//                completion(.failure(error))
//
//            } else {
//                print("delete success")
//                completion(.success(selectedData.id))
//            }
//        }
//    }
////        if !UserManager.shared.isLogin() {
////            print("who r u?")
////            return
////        }
//
////        if let user = meeting.owner {
////            if user.id == "5gWVjg7xTHElu9p6Jkl1"
////                && meeting.category.lowercased() != "test"
////                && !meeting.category.trimmingCharacters(in: .whitespaces).isEmpty
////        {
////                completion(.failure(MasterError.youKnowNothingError("You know nothing!! \(user.id)")))
////                return
////            }
////        }
//
//
//}
