//
//  SelectedOption.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit
import FirebaseFirestoreSwift

struct SelectedOption: Codable {
    var id: String
    var isSelected: Bool?
    var selectedUser: String?
    
    enum CodingKeys: String, CodingKey {
        case isSelected, selectedUser, id
    }
    
    init(isSelected: Bool, selectedUser: String?) {
        self.isSelected = false
        self.selectedUser = "selectedUser"
        self.id = "id"
    }
    
    var toDict: [String: Any] {
        return [
            "id": id,
            "selectedOption": isSelected as Any,
            "selectedUser": selectedUser as Any
            
        ]
    }
}
