//
//  AskInfo.swift
//  inviti
//
//  Created by Hannah.C on 11.05.21.
//

import UIKit

class AskInfo: Codable {

    let id: String
    let phone: String
    let address: String
    let email: String

    enum CodingKeys: String, CodingKey {
        case id, email, phone, address

    }

    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "email": email as Any,
            "phone": phone as Any,
            "address": address as Any
        ]
    }

}
