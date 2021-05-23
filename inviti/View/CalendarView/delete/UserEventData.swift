//
//  UserBookingData.swift
//  inviti
//
//  Created by Hannah.C on 23.05.21.
//

import Foundation

struct UserEventData {
    let pathID: String
    let bookingTime: BookingTimeAndRoom
    let status: String
//    let pathID: String
//    let userInfo: UserData
    let userUID: String
    let store: String
    let title: String

    init? (dictionary: [String: Any]) {

        guard let bookingTime = BookingTimeAndRoom(dictionary: dictionary) else {return nil}
        guard let userInfo = dictionary[FirebaseBookingKey.user.rawValue] as? [String: Any] else { return nil }
        guard let pathID = dictionary[FirebaseBookingKey.pathID.rawValue] as? String else {return nil}
        guard let userUID = userInfo[UsersKey.uid.rawValue] as? String else {return nil}
//        guard let user = UserData(dictionary: userInfo) else {return nil}
        guard let status = dictionary[FirebaseBookingKey.status.rawValue] as? String else {return nil}
        guard let store = dictionary[FirebaseBookingKey.store.rawValue] as? String  else {return nil}
       
        if let storeMessage = dictionary[FirebaseBookingKey.storeMessage.rawValue] as? String {

            self.title = storeMessage
        } else {

            self.title = "尚未回應"
        }
        self.bookingTime = bookingTime
        self.status = status
        self.pathID = pathID
//        self.userInfo = user
        self.userUID = userUID
        self.store = store
    }

    func returnStatusString() -> String {

        switch status {
        case BookingStatus.confirm.rawValue:
            return BookingStatus.confirm.display
        case BookingStatus.refuse.rawValue:
            return BookingStatus.refuse.display
        case BookingStatus.tobeConfirm.rawValue:
            return BookingStatus.tobeConfirm.display
        default:
            return "BUG"
        }
    }
}

struct UserListData {

    let documentID: String
    let store: String

    init?(dictionary: [String: Any]) {

        guard let listID = dictionary[UsersKey.documentID.rawValue] as? String else { return nil }
        guard let storeName = dictionary[UsersKey.store.rawValue] as? String else { return nil }
        self.documentID = listID
        self.store = storeName
    }
}
