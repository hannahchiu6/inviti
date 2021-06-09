//
//  SettingsViewModel.swift
//  inviti
//
//  Created by Hannah.C on 04.06.21.
//

import UIKit

class SettingsViewModel {

    var onGranted: (() -> Void)?

    var userViewModel = Box(UserViewModel(model: User(id: "", email: "", name: "", image: "", phone: "", address: "", calendarType: "", numOfMeetings: 0, events: [], notification: [], numberForSearch: "")))

    var refreshView: (() -> Void)?

    func onNameChanged(text name: String) {
        self.userViewModel.value.user.name = name

    }

    func onEmailChanged(text email: String) {
        self.userViewModel.value.user.email = email
    }

    func onImageUploaded(url: String) {
        self.userViewModel.value.user.image = url
//        self.updateImage(url: url)
    }

    var user: User = User(id: "", email: "", name: "", image: "", phone: "", address: "", calendarType: "", numOfMeetings: 0, numberForSearch: "")

    func onRefresh() {

        self.refreshView?()
    }

    func fetchUserData() {

        UserManager.shared.fetchProfileUser { [weak self] result in

            switch result {

            case .success(let user):

                self?.setUser(user)

            case .failure(let error):

                print("fetchData.failure: \(error)")
            }
        }
    }


    func updateUserProfile() {
        let newUserData = self.userViewModel.value.user
        UserManager.shared.updateUserDetails(user: newUserData) { result in
            switch result {

            case .success(let user):

                self.setupUserDefault(user: user)

                print("Publish Image Succeeded")

            case .failure(let error):

                print("publishArticle.failure: \(error)")

            }
        }
    }

    func setupUserDefault(user: User) {

        UserDefaults.standard.setValue(user.image, forKey: UserDefaults.Keys.image.rawValue)

        UserDefaults.standard.setValue(user.name, forKey: UserDefaults.Keys.displayName.rawValue)

        UserDefaults.standard.setValue(user.email, forKey: UserDefaults.Keys.email.rawValue)

    }

    func uploadImage(with image: UIImage) {

        UserManager.shared.uploadImage(selectedImage: image) { result in
            switch result {

            case .success(let imageUrl):

                self.onImageUploaded(url: imageUrl)

                print("Publish Image Succeeded")

            case .failure(let error):

                print("publishArticle.failure: \(error)")

            }
        }
    }
    func updateImage(url: String) {

        UserManager.shared.updateUserImageURL(url: url) { result in

            switch result {

            case .success( _):

                print("Publish Image Succeeded")

            case .failure(let error):

                print("publishArticle.failure: \(error)")

            }
        }
    }

    func updateUserName(name: String) {
        UserManager.shared.updateUserName(name: name)
    }

    func updateUserEmail(email: String) {
        UserManager.shared.updateUserEmail(email: email)
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

    func convertUserToViewModel(from user: User) -> UserViewModel {

        let viewModel = UserViewModel(model: user)

        return viewModel
    }

    func setUser(_ user: User) {
        userViewModel.value = convertUserToViewModel(from: user)
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
