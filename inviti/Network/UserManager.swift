//
//  UserManager.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation

enum LoginError: Error {
    case idNotExistError(String)
}

class UserManager {

    static let shared = UserManager()

    var user: User?

    func login(id: String = "", completion: @escaping (Result<User, Error>) -> Void) {

        switch id {
        case "moon2021":
            user = User(
                id: id,
                email: "moon2021@gmail.com",
                firstName: "小月",
                lastName: "邱",
                appleID: "",
                image: "",
                phone: "",
                address: "",
                isCalendarSynced: false,
                calendarType: "",
                numOfMeetings: 66
            )
            completion(.success(user!))

        //MARK: add your profile here
        default:
            completion(.failure(LoginError.idNotExistError("You have to add \(id) info in local data source")))
        }
    }

    func isLogin() -> Bool {
        return user != nil
    }
}
