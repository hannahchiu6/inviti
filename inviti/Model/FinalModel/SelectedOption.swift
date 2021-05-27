//
//  SelectedOption.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit
import FirebaseFirestoreSwift

struct SelectedOption: Codable {
//    let  id: String
    @DocumentID var id: String?
    var isSelected: Bool?
    var selectedUser: String?

    enum CodingKeys: String, CodingKey {
        case isSelected, selectedUser
    }

    init(isSelected: Bool, selectedUser: String?) {
        self.isSelected = false
        self.selectedUser = "selectedUser"
    }

    var toDict: [String: Any] {
        return [

            "selectedOption": isSelected as Any,
            "selectedUser": selectedUser as Any

        ]
    }
}
