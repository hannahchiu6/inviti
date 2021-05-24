//
//  StoreData.swift
//  inviti
//
//  Created by Hannah.C on 23.05.21.
//

import Foundation

struct StoreData {

    var name: String
    var openTime: String
    var closeTime: String
    var phone: String
    var address: String
    var photourl: String
    var information: String
    var rooms: [Room] = []
    var city: String
    var images: [String] = []
    var tokens: [String] = []

    struct Room {

        var name: String
        var price: String
        init (name: String, price: String) {

            self.name = name
            self.price = price
        }

        init() {

            self.name = ""
            self.price = ""
        }
    }

    init() {
        self.name = ""
        self.openTime = ""
        self.closeTime = ""
        self.address = ""
        self.city = ""
        self.information = ""
        self.phone = ""
        self.photourl = ""
    }

    init? (dictionary: [String: Any]) {

        guard let name = dictionary[StoreDataKey.name.rawValue] as? String else {return nil}
        guard let openTime = dictionary[StoreDataKey.opentime.rawValue] as? String else {return nil}
        guard let closeTime = dictionary[StoreDataKey.closetime.rawValue] as? String else {return nil}
        guard let phone = dictionary[StoreDataKey.phone.rawValue] as? String else {return nil}
        guard let address = dictionary[StoreDataKey.address.rawValue] as? String else {return nil}
        guard let photourl = dictionary[StoreDataKey.photourl.rawValue] as? String else {return nil}
        guard let information = dictionary[StoreDataKey.information.rawValue] as? String else {return nil}
        guard let rooms = dictionary[StoreDataKey.rooms.rawValue] as? [[String: Any]] else {return nil}
        guard let city = dictionary[StoreDataKey.city.rawValue] as? String else {return nil}

        for room in rooms {

            guard let name = room[StoreDataKey.name.rawValue] as? String else {return nil}
            guard let price = room[StoreDataKey.price.rawValue] as? String else {return nil}
            let roomData = Room(name: name, price: price)
            self.rooms.append(roomData)
        }

        if let images = dictionary[StoreDataKey.images.rawValue] as? [String] {

            self.images = images
        }
        self.name = name
        self.openTime = openTime
        self.closeTime = closeTime
        self.phone = phone
        self.address = address
        self.photourl = photourl
        self.information = information
        self.city = city

        if let tokens = dictionary[StoreDataKey.token.rawValue] as? [String] {

            self.tokens = tokens
        }
    }

    func getStoreOpenHours() -> Int {

        guard let close = Int(closeTime) else {return 0}
        guard let open = Int(openTime) else {return 0}
        return close - open
    }

    func getFirebaseDictionay() -> [String: Any] {
        var imagesArray: [String] = []
        for image in self.images {

            imagesArray.append(image)
        }
        var roomsArray: [[String: Any]] = []
        for room in self.rooms {

            let roomDictionary = [StoreDataKey.name.rawValue: room.name,
                                  StoreDataKey.price.rawValue: room.price]
            roomsArray.append(roomDictionary)
        }

        let dictionay: [String: Any] = [
            StoreDataKey.name.rawValue: self.name,
            StoreDataKey.opentime.rawValue: self.openTime,
            StoreDataKey.closetime.rawValue: self.closeTime,
            StoreDataKey.phone.rawValue: self.phone,
            StoreDataKey.address.rawValue: self.address,
            StoreDataKey.information.rawValue: self.information,
            StoreDataKey.city.rawValue: self.city,
            StoreDataKey.photourl.rawValue: self.photourl,
            StoreDataKey.images.rawValue: imagesArray,
            StoreDataKey.rooms.rawValue: roomsArray]

        return dictionay
    }

//    mutating func putDataInEnumDictionay(dataString: [ProfileContentCategory: String]) throws {
//
//        if let name = dataString[.storeName], name.isEmpty == false {
//
//            self.name = name
//
//        } else {
//
//            throw InputError.storeName
//        }
//
//        if let city = dataString[ .storeCity], city.isEmpty == false {
//
//            self.city = city
//        } else {
//
//            throw InputError.storeCity
//        }
//
//        if let phone = dataString[ .storePhone], phone.isEmpty == false {
//
//            if Int(phone) != nil {
//
//                if phone.count > 6 {
//
//                    self.phone = phone
//                } else {
//
//                    throw InputError.phoneIsLessThanSeven
//                }
//            } else {
//
//                throw InputError.phoneIsNotNumber
//            }
//        } else {
//
//            throw InputError.phoneIsEmpty
//        }
//        if let address = dataString[ .address], address.isEmpty == false {
//
//            self.address = address
//
//        } else {
//
//            throw InputError.address
//        }
//
//        var open = 0
//        if let openTime = dataString[ .openTime], openTime.isEmpty == false {
//
//            if let openNumber = Int(openTime) {
//
//                if openTime.count == 2 {
//
//                    self.openTime = openTime
//                    open = openNumber
//                } else {
//
//                    throw InputError.openTimeIsNotTwoCount
//                }
//            } else {
//
//                throw InputError.openTimeIsNotNumber
//            }
//        } else {
//
//            throw InputError.openTimeIsEmpty
//        }
//
//        var close = 0
//        if let closeTime = dataString[ .closeTime], closeTime.isEmpty == false {
//
//            if let closeNumber = Int(closeTime) {
//
//                if closeTime.count == 2 {
//
//                    self.closeTime = closeTime
//                    close = closeNumber
//                } else {
//
//                    throw InputError.closeTimeIsNotTwoCount
//                }
//            } else {
//
//                throw InputError.closeTimeIsNotNumber
//            }
//        } else {
//
//            throw InputError.closeTimeIsEmpty
//        }
//
//        if open >= close {
//
//            throw InputError.openTimeThanCloseTime
//        }
//
//        if let information = dataString[ .information], information.isEmpty == false {
//
//            self.information = information
//        } else {
//
//            throw InputError.information
//        }
//    }
//
//    mutating func addRooms(rooms: [Room]) throws {
//
//        for index in 0 ..< rooms.count {
//
//            if rooms[index].name.isEmpty {
//
//                throw InputError.roomName(index + 1)
//            }
//            if rooms[index].price.isEmpty {
//
//                throw InputError.priceIsEmpty(index + 1)
//            }
//
//            if Int(rooms[index].price) == nil {
//
//                throw InputError.priceIsNotNumber(index + 1)
//            }
//        }
//        self.rooms = rooms
//    }

    func returnStorePriceLowToHigh() -> String {

        let priceInt = rooms.compactMap({Int($0.price)}).sorted(by: <)

        if priceInt.isEmpty {

            return "錯誤"
        }
        if priceInt.count == 1 {

            return "每小時 $\(priceInt[0])"
        } else {
            let last = priceInt.count - 1

            return "每小時 $\(priceInt[0]) - $\(priceInt[last])"
        }
    }

    func returnRoomAndPrices() -> String {
        let roomString = rooms.compactMap({$0.name + " : $" + $0.price})
        let priceString = roomString.joined(separator: "\n")

        return priceString
    }
}
