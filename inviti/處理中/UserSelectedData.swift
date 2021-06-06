//
//  UserSelectedData.swift
//  inviti
//
//  Created by Hannah.C on 23.05.21.
//

import Foundation

struct UserSelectedData {
    let id: String
    let selectedOption: OptionsData
    let status: String
//    let pathID: String
    let userInfo: SimpleUser
    let userUID: String
    let meetingID: String
//    let title: String

    var toDict: [String: Any] {
        return [
            "id": id as Any,
            "selectedOption": selectedOption.toDict as Any,
            "status": status as Any,
            "userUID": userUID as Any,
            "meetingID": meetingID as Any,
            "userInfo": userInfo.toDict as Any,
//            "title": title as Any
        ]
    }

//    init? (dictionary: [String: Any]) {
//
//        guard let bookingTime = selectedOption.toDict else {return nil}
//        guard let userInfo = dictionary[FBBookingKey.user.rawValue] as? [String: Any] else { return nil }
//        guard let pathID = dictionary[FBBookingKey.pathID.rawValue] as? String else {return nil}
//        guard let userUID = userInfo[UsersKey.uid.rawValue] as? String else {return nil}
////        guard let user = UserData(dictionary: userInfo) else {return nil}
//        guard let status = dictionary[FBBookingKey.status.rawValue] as? String else {return nil}
//        guard let store = dictionary[FBBookingKey.store.rawValue] as? String  else {return nil}
//
//        if let storeMessage = dictionary[FBBookingKey.storeMessage.rawValue] as? String {
//
//            self.title = storeMessage
//        } else {
//
//            self.title = "尚未回應"
//        }
//        self.bookingTime = bookingTime
//        self.status = status
//        self.id = pathID
////        self.userInfo = user
//        self.userUID = userUID
//        self.store = store
//    }

}
