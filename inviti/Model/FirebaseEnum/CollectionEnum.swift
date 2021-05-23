//
//  CollectionEnum.swift
//  inviti
//
//  Created by Hannah.C on 24.05.21.
//

import Foundation

enum FirebaseCollectionName {

    case user
    case store
    case bookingConfirm
    case meeting

    var name: String {

        switch self {
        case .user:
            return "Users"
        case .store:
            return "Store"
        case .bookingConfirm:
            return "BookingConfirm"
        case .meeting:
            return "Meeting"

        }
    }
}
