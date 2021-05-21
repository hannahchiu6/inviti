//
//  OptionSelected.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit
import FirebaseFirestoreSwift

struct OptionSelected: Codable {
    let  id: String
//    @Document var id: String?
    let selectedOption: String
    let selectedUser: String

    enum CodingKeys: String, CodingKey {
        case id, selectedOption, selectedUser
    }

    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "selectedOption": selectedOption as Any,
            "selectedUser": selectedUser as Any

        ]
    }
}
