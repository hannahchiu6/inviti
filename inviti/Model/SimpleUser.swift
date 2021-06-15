////
////  SimpleUser.swift
////  inviti
////
////  Created by Hannah.C on 11.05.21.
////
//
//import UIKit
//import FirebaseFirestoreSwift
//
//struct SimpleUser: Identifiable, Codable {
//    let id: String
//    var email: String
//    var image: String?
//
//    enum CodingKeys: String, CodingKey {
//        case email, image, id
//    }
//
//    var toDict: [String: Any] {
//        return [
//            "id": id,
//            "email": email,
//            "image": image as Any
//        ]
//    }
//}
