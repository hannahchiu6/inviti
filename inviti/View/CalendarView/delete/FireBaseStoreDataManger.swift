//
//  File.swift
//  inviti
//
//  Created by Hannah.C on 23.05.21.
//


import Foundation
import Firebase

enum StoreDataKey: String {

    case name
    case opentime
    case closetime
    case phone
    case address
    case photourl
    case rooms
    case price
    case information
    case city
    case images
    case token
}

class FireBaseStoreDataManger {

//    private lazy var fireStoreDatabase = FirebaseManager.shared.fireStoreDatabase()
//
//    private let firebaseReadAndWrite: FirebaseReadAndWrite
//
//    init(firebaseManger: FirebaseReadAndWrite = FirebaseManager.shared as! FirebaseReadAndWrite) {
//        self.firebaseReadAndWrite = firebaseManger
//    }

//    func getStoresData(completionHandler: @escaping (Result<[StoreData]>) -> Void) {
//
//        let ref = fireStoreDatabase.collectionName(.store)
//        firebaseReadAndWrite.collectionGetDocuments(ref: ref) { (result) in
//
//            switch result {
//
//            case .success(let datas):
//
//                do {
//                    let storedatas = try DataTransform.dataArrayReturnWithoutOption(
//                        datas: datas.map({StoreData(dictionary: $0)})
//                    )
//
//                    FirebaseManager.shared.storeDatas = storedatas
//                    completionHandler(.success(storedatas))
//                } catch {
//
//                    completionHandler(.failure(error))
//                }
//            case .failure(let error):
//
//                completionHandler(.failure(error))
//            }
//        }
//    }

//    func updateStoreData(storeData: StoreData, completionHandler: @escaping (Result<String>) -> Void) {
//
//        let fireBaseData = storeDataToFirebaseData(storeData: storeData)
//        let ref = fireStoreDatabase.collectionName(.store).document(storeData.name)
//        firebaseReadAndWrite.documentUpdata(ref: ref, data: fireBaseData) { (result) in
//            switch result {
//            case .success:
//
//                completionHandler(.success(FBStoreMessage.updata.message))
//            case .failure(let error):
//
//                completionHandler(.failure(error))
//            }
//        }
//    }

    private func storeDataToFirebaseData(storeData: StoreData) -> [String: Any] {

        var imagesArray: [String] = []
        for image in storeData.images {

            imagesArray.append(image)
        }
        var roomsArray: [[String: Any]] = []
        for room in storeData.rooms {

            let roomDictionary = [StoreDataKey.name.rawValue: room.name,
                                  StoreDataKey.price.rawValue: room.price]
            roomsArray.append(roomDictionary)
        }

        let dictionay: [String: Any] = [
            StoreDataKey.name.rawValue: storeData.name,
            StoreDataKey.opentime.rawValue: storeData.openTime,
            StoreDataKey.closetime.rawValue: storeData.closeTime,
            StoreDataKey.phone.rawValue: storeData.phone,
            StoreDataKey.address.rawValue: storeData.address,
            StoreDataKey.information.rawValue: storeData.information,
            StoreDataKey.city.rawValue: storeData.city,
            StoreDataKey.photourl.rawValue: storeData.photourl,
            StoreDataKey.images.rawValue: imagesArray,
            StoreDataKey.rooms.rawValue: roomsArray]

        return dictionay
    }
}

//protocol FirebaseReadAndWrite {
//
//    func collectionGetDocuments(ref: CollectionReference, completionHandler: @escaping (Result<[String: Any]>) -> Void)
//
//    func documentUpdata(ref: DocumentReference,
//                        data: [AnyHashable: Any],
//                        completionHandler: @escaping (Result<Bool>) -> Void
//    )
//}
