//
//  File.swift
//  inviti
//
//  Created by Hannah.C on 23.05.21.
//

import Foundation
import Firebase

class FirebaseManager {

//    typealias AuthResult = (AuthDataResult?, Error?) -> Void
//    typealias ListeningResult = (Auth, User?) -> Void
//
//    static let shared = FirebaseManager()
//    let user = { Auth.auth() }
//    let fireStoreDatabase = { Firestore.firestore() }
//    let userCollection = FirebaseEnum.user.rawValue
//    var listener: ListenerRegistration?
//    var userData: UserData? {
//        didSet {
//
//            if self.userData?.status == UsersKey.Status.user.rawValue {
//
//                self.userStatus = UsersKey.Status.user.rawValue
//            }
//            if self.userData?.status == UsersKey.Status.manger.rawValue {
//
//                self.userStatus = UsersKey.Status.manger.rawValue
//            }
//
//            NotificationCenter.default.post(
//                name: NSNotification.userData,
//                object: self.userData)
//        }
//    }
//
//    var storeName: [String] = [] {
//
//        didSet {
//
//            setStoresToken()
//        }
//    }
//    var storeDatas: [StoreData] = []
//    var userBookingData: [UserBookingData] = [] {
//        didSet {
//            postBookingData(data: userBookingData)
//        }
//    }
//    var mangerStoreData: [UserBookingData] = [] {
//        didSet {
//            postBookingData(data: mangerStoreData)
//        }
//    }
//    var userStatus: String = String() {
//        didSet {
//
//            getMangerStoreName()
//        }
//    }
//    private init () {}
//
//    private func setStoresToken() {
//        guard let token = Messaging.messaging().fcmToken else { return }
//        for store in storeName {
//
//            if storeDatas.first(where: {$0.name == store})?.tokens.contains(token) ?? true {
//
//
//            } else {
//                fireStoreDatabase().collectionName(.store).document(store).updateData([StoreDataKey.token.rawValue: FieldValue.arrayUnion([token])])
//            }
//        }
//    }
//
//    private func postBookingData(data: [UserBookingData]) {
//
//        NotificationCenter.default.post(
//            name: NSNotification.bookingData,
//            object: data)
//    }
//
//    func configure() {
//
//        FirebaseApp.configure()
//        FirebaseManager.shared.listenAccount { (_, user) in
//
//            if let user = user {
//
//               self.listener = self.fireStoreDatabase()
//                .collection(self.userCollection).document(user.uid).addSnapshotListener(
//                    includeMetadataChanges: true,
//                    listener: { (querySnapshot, _) in
//
//                        guard let dictionary = querySnapshot?.data() else {
//                            return
//                        }
//
//                        let userData = UserData(dictionary: dictionary)
//                        self.userData = userData
//                        guard let token = Messaging.messaging().fcmToken else {return}
//                        if self.userData?.tokens.contains(token) ?? true {
//
//                        } else {
//
//                            self.fireStoreDatabase().collectionName(.user)
//                                .document(user.uid).updateData([UsersKey.token.rawValue: FieldValue.arrayUnion([token])])
//                        }
//                })
//            } else {
//
//                self.listener?.remove()
//            }
//        }
//    }
//
//    private func resetData() {
//
//        self.storeDatas = []
//        self.userData = nil
//        self.userBookingData = []
//        self.mangerStoreData = []
//        self.userStatus = String()
//        self.storeName = []
//    }
//
//    func listenAccount(completionHandler: @escaping ListeningResult) {
//        Auth.auth().addStateDidChangeListener(completionHandler)
//    }
//
//    func logout(completionHandler: (Result<String>) -> Void) {
//
//        do {
//
//            guard let uid = user().currentUser?.uid, let token = Messaging.messaging().fcmToken else {
//                completionHandler(.failure(FireBaseError.unknow))
//                return
//            }
//            fireStoreDatabase().collectionName(.user)
//                .document(uid).updateData([UsersKey.token.rawValue: FieldValue.arrayRemove([token])])
//            resetStoreToken(token: token)
//            try Auth.auth().signOut()
//            resetData()
//            completionHandler(.success(FirebaseEnum.logout.rawValue))
//        } catch let signOutError as NSError {
//            completionHandler(.failure(signOutError))
//        }
//    }
//
//    private func resetStoreToken(token: String) {
//
//        for store in storeName {
//
//            fireStoreDatabase().collectionName(.store).document(store).updateData([StoreDataKey.token.rawValue: FieldValue.arrayRemove([token])])
//        }
//    }
//
//    func editProfileInfo(userData: UserData, completionHandler: @escaping (Error?) -> Void = {_ in }) {
//        guard let uid = user().currentUser?.uid else {
//
//            completionHandler(AccountError.noLogin)
//            return
//        }
//        let dictionary = DataTransform.userData(userData: userData)
//        fireStoreDatabase()
//            .collection(FirebaseEnum.user.rawValue)
//            .document(uid).setData(dictionary, merge: true) { error in
//            if error == nil {
//
//                self.getUserInfo()
//            }
//            completionHandler(error)
//        }
//    }
//
//    func bookingTimeCreat(storeName: String, bookingDatas: [BookingTimeAndRoom],
//                         userMessage: String, completionHandler: @escaping (Result<String>) -> Void) {
//
//        guard let uid = user().currentUser?.uid else {
//            completionHandler(.failure(AccountError.noLogin))
//            return
//        }
//        guard let user = FirebaseManager.shared.userData else {
//
//            return
//        }
//        var count = 0
//        var haveError = false
//        for bookingData in bookingDatas {
//            let document = fireStoreDatabase()
//                .collection(FirebaseEnum.store.rawValue).document(storeName)
//                .collection(FirebaseEnum.confirm.rawValue).document()
//            let documentID = document.documentID
//            let dictionary = DataTransform.getUserBookingDictionary(
//                bookingData: bookingData, documentID: documentID, uid: uid,
//                user: user, name: storeName, userMessage: userMessage)
//            document.setData(
//                dictionary, merge: true,
//                completion: { (error) in
//                count += 1
//                if let error = error {
//                    haveError = true
//
//                    if count == bookingDatas.count {
//
//                        completionHandler(.failure(error))
//                    }
//                } else {
//
//                    self.cloneBookingData(
//                        dictionary: dictionary, uid: uid,
//                        storeName: storeName, documentID: documentID)
//                    if count == bookingDatas.count {
//                        if haveError {
//
//                            completionHandler(.failure(InputError.bookingCreat))
//                        } else {
//
//                            completionHandler(.success(FirebaseEnum.addBooking.rawValue))
//                        }
//                    }
//                }
//            })
//        }
//    }
//    private func cloneBookingData(dictionary: [String: Any], uid: String, storeName: String, documentID: String) {
//
//        let documemntInBooking = fireStoreDatabase().collection(FirebaseEnum.booking.rawValue)
//            .document(storeName).collection(uid).document(documentID)
//
//        documemntInBooking.setData(dictionary, merge: true)
//
//        let documentInUser = fireStoreDatabase().collection(FirebaseEnum.user.rawValue)
//            .document(uid).collection(FirebaseEnum.booking.rawValue).document(documentID)
//
//        documentInUser.setData(dictionary, merge: true)
//
//        let documentInStoreBooking = fireStoreDatabase().collection(FirebaseEnum.store.rawValue)
//            .document(storeName).collection(FirebaseEnum.booking.rawValue).document(documentID)
//
//        documentInStoreBooking.setData(dictionary, merge: true)
//    }
//
//    func getUserBookingData() {
//
//        guard let uid = user().currentUser?.uid else {
//            self.userBookingData = []
//            return
//        }
//        let userBookingDocument = fireStoreDatabase().collection(FirebaseEnum.user.rawValue)
//            .document(uid).collection(FirebaseEnum.booking.rawValue)
//
//        userBookingDocument.getDocuments { (querySnapshot, _) in
//
//            guard let documents = querySnapshot else {
//                self.userBookingData = []
//                return
//            }
//
//            if documents.documents.isEmpty {
//                self.userBookingData = []
//                return
//            }
//
//            var bookingDatas: [UserBookingData] = []
//            for document in documents.documents {
//
//                guard let bookingData = UserBookingData(dictionary: document.data()) else {
//                    self.userBookingData = []
//                    return
//                }
//               bookingDatas.append(bookingData)
//            }
//            self.userBookingData = bookingDatas
//        }
//    }
//    func uploadIamge(uniqueString: String, image: UIImage, completionHandler: @escaping (Result<String>) -> Void) {
//
//        let storageRef = Storage.storage().reference().child("\(uniqueString).png")
//        if let uploadData = UIImage.pngData(image)() {
//            storageRef.putData(uploadData, metadata: nil) { (_, error) in
//                if let error = error {
//
//                    completionHandler(.failure(error))
//                    return
//                }
//                storageRef.downloadURL(completion: { (url, error) in
//
//                    if let error = error {
//
//                        completionHandler(.failure(error))
//                        return
//                    }
//                    guard let url = url?.absoluteString else {
//                        completionHandler(.failure(InputError.imageURLDidNotGet))
//                        return
//                    }
//                    self.uploadUserImageURL(url: url, completionHandler: completionHandler)
//                })
//            }
//        }
//    }
//
//    private func uploadUserImageURL(url: String, completionHandler: @escaping ((Result<String>) -> Void)) {
//        guard let uid = user().currentUser?.uid else {
//            completionHandler(.failure(AccountError.noLogin))
//            return
//        }
//        fireStoreDatabase().collection(FirebaseEnum.user.rawValue).document(uid)
//            .setData([UsersKey.photoURL.rawValue: url], merge: true) { (error) in
//
//            if let error = error {
//                completionHandler(.failure(error))
//                return
//            }
//            completionHandler(.success(FirebaseEnum.uploadSuccess.rawValue))
//        }
//    }
//
//    func getMangerBookingData() {
//
//        self.mangerStoreData = []
//        for store in self.storeName {
//            let mangerBookingDocument = fireStoreDatabase().collection(FirebaseEnum.store.rawValue).document(store)
//                .collection(FirebaseEnum.booking.rawValue)
//            mangerBookingDocument.getDocuments { (querySnapshot, error) in
//
//                if error != nil {
//
//                    if store == self.storeName.last {
//
//                        self.mangerStoreData = []
//                    }
//                    self.mangerStoreData = []
//                    return
//                }
//                guard let documents = querySnapshot?.documents else {
//                    self.mangerStoreData = []
//                    return
//                }
//
//                if documents.isEmpty {
//                    self.mangerStoreData = []
//                    return
//                }
//                for document in documents {
//
//                    guard let data = UserBookingData(dictionary: document.data()) else {
//                        self.mangerStoreData = []
//                        return
//                    }
//                    self.mangerStoreData.append(data)
//                }
//            }
//        }
//    }
//
//    private func getMangerMessage(listID: String, storeName: String, uid: String) {
//
//        self.mangerStoreData = []
//        fireStoreDatabase().collection(FirebaseEnum.store.rawValue).document(storeName)
//            .collection(FirebaseEnum.confirm.rawValue).getDocuments { (querySnapshot, error) in
//
//                if error != nil {
//
//                    return
//                }
//
//                guard let documents = querySnapshot?.documents else {return}
//
//                for document in documents {
//
//                    guard let data = UserBookingData(dictionary: document.data()) else {return}
//
//                    self.mangerStoreData.append(data)
//                }
//        }
//    }
//
//    func updataBookingConfirm(storeName: String, pathID: String, userUID: String,
//                              storeMessage: String = FirebaseBookingKey.storeMessage.description,
//                              completionHandler: @escaping (Result<String>) -> Void) {
//
//        fireStoreDatabase().collection(FirebaseEnum.store.rawValue).document(storeName)
//            .collection(FirebaseEnum.confirm.rawValue).document(pathID)
//            .updateData([FirebaseBookingKey.status.rawValue: FirebaseBookingKey.Status.confirm.rawValue]) { (error) in
//                if let error = error {
//
//                    completionHandler(.failure(error))
//                } else {
//
//                   self.updataBookingColloection(
//                    storeName: storeName, pathID: pathID, userUID: userUID,
//                    status: .confirm, storeMessage: storeMessage,
//                    completionHandler: completionHandler)
//                }
//        }
//    }
//
//    private func updataBookingColloection(storeName: String,
//                                          pathID: String,
//                                          userUID: String,
//                                          status: FirebaseBookingKey.Status,
//                                          storeMessage: String,
//                                          completionHandler: @escaping (Result<String>) -> Void) {
//
//        var dictionary: [String: Any] = [:]
//        switch status {
//        case .confirm:
//            dictionary = [FirebaseBookingKey.status.rawValue: FirebaseBookingKey.Status.confirm.rawValue]
//        case .refuse:
//            dictionary = [FirebaseBookingKey.status.rawValue: FirebaseBookingKey.Status.refuse.rawValue]
//        case .tobeConfirm:
//            dictionary = [FirebaseBookingKey.status.rawValue: FirebaseBookingKey.Status.tobeConfirm.rawValue]
//        }
//        dictionary.updateValue(storeMessage, forKey: FirebaseBookingKey.storeMessage.rawValue)
//
//        fireStoreDatabase().collection(FirebaseEnum.user.rawValue).document(userUID)
//            .collection(FirebaseEnum.booking.rawValue).document(pathID).updateData(dictionary) { (error) in
//
//            if let error = error {
//
//                completionHandler(.failure(error))
//            } else {
//
//                completionHandler(.success(FirebaseEnum.mangerConfirm.rawValue))
//                self.fireStoreDatabase().collection(FirebaseEnum.store.rawValue).document(storeName)
//                    .collection(FirebaseEnum.booking.rawValue).document(pathID).updateData(dictionary)
//            }
//        }
//    }
//
//    func refuseBooking(pathID: String, storeName: String,
//                       userUID: String, storeMessage: String, completionHandler: @escaping (Result<String>) -> Void) {
//        fireStoreDatabase().collection(FirebaseEnum.store.rawValue).document(storeName)
//            .collection(FirebaseEnum.confirm.rawValue).document(pathID).delete { (error) in
//
//                if let error = error {
//
//                    completionHandler(.failure(error))
//                    return
//                } else {
//                    self.updataBookingColloection(
//                        storeName: storeName, pathID: pathID, userUID: userUID,
//                        status: .refuse, storeMessage: storeMessage, completionHandler: completionHandler)
//                }
//        }
//    }
}
