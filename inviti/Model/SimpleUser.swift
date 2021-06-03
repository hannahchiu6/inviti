//
//  SimpleUser.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit
import FirebaseFirestoreSwift

struct SimpleUser: Identifiable, Codable {
    let id: String
//    @DocumentID var id: String?
    var email: String
//    let name: String
    var image: String?

    enum CodingKeys: String, CodingKey {
        case email, image, id
    }

    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "email": email as Any,
//            "name": name as Any,
            "image": image as Any,
        ]
    }
}
