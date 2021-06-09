//
//  LoginViewModel.swift
//  inviti
//
//  Created by Hannah.C on 04.06.21.
//

import Foundation

class LoginViewModel {

    var onGranted: (() -> Void)?

    var userViewModels = Box([UserViewModel]())

    var user: User = User(id: "", email: "", name: "", image: "", phone: "", address: "", calendarType: "", numOfMeetings: 0, numberForSearch: "")

    func fetchUser(user: User) {

        UserManager.shared.fetchUser(user: user) { result in

            switch result {
            case .success(let user):

                guard user != nil else {

                    self.create(with: &self.user)
                    
                    return
                }

                self.user = user


//                switch result {
//                case .success(let user):
//                    if user.appleID == uid {
//
//                        self.user = user
//
//                        return } else {
//
//                    self.create(with: &self.user, uid: uid)
//
//                    }
            case .failure(let error):
                print(error)
            }
        }
    }

    func checkIfLogInBefore() {
        UserManager.shared.didLoginBefore(completion: { result in

            switch result {

            case .success(let users):

                guard !users.isEmpty else {

                    self.createUser()

                    return
                }

                self.user = users[0]
                self.setupUserDefault(user: users[0])
                self.onGranted?()

            case .failure(let error):

                print(error)
            }
        })
    }

    func setupUserDefault(user: User) {

        UserDefaults.standard.setValue(user.image, forKey: UserDefaults.Keys.image.rawValue)

        UserDefaults.standard.setValue(user.name, forKey: UserDefaults.Keys.displayName.rawValue)

//        UserDefaults.standard.setValue(user.id, forKey: UserDefaults.Keys.uid.rawValue)

        UserDefaults.standard.setValue(user.email, forKey: UserDefaults.Keys.email.rawValue)

    }

    func createUser() {

        UserManager.shared.createNewUser(completion: { result in

            switch result {

            case .success(let message):

                print(message)
                
                self.onGranted?()

            case .failure(let error):

                print(error)
            }
        })
    }


    func create(with user: inout User) {

        UserManager.shared.createUser(user: &user,
                                          completion: { result in
                                            
            switch result {

            case .success(let message):

                print(message)
                self.onGranted?()

            case .failure(let error):

                print(error)
            }
        })
    }

}
