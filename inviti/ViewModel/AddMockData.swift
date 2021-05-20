//
//  AddMockData.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import Firebase

class AddMockDataManager {

    let db = Firestore.firestore()
    let documentID = String(Date().timeIntervalSince1970)
    let users: [User] = []

    func addData() {
        let users = Firestore.firestore().collection("users")
        let document = users.document()
        let data: [String: Any] = [
            "firstName": "台東阿美",
            "lasttName": "夢幻",
            "email": "taidung@gmail.com",
            "id": document.documentID,
            "category": "Travel",
            "appleID": "ZQSFWRGRGQF93E67Z",
            "image": "https://images.app.goo.gl/b6VXmkfku1HHqa4p9",
            "isCalendarSynced": false,
            "numOfMeetings" : 10,
            "address": "台灣台東市中正路 199 號",
            "phone": "0922001111"

        ]

        document.setData(data)

    }

}

// [
//    "author": [
//                "email": "max@school.appworks.tw",
//                "id": "max2021",
//                "name": "密室逃脫者"
//              ],
//    "title": "台東阿美族人靠海而生，在離岸小島上養羊，過著自給自足的生活",
//    "content": "私房台東景點金剛大道，因為這裡山的形狀像金剛而得名，整條路沒有電線桿及任何建築物，一眼望去金剛大道、綠油油的稻田和遠方海景盡收眼底，搭配藍天白雲，海天連成一線，沒想到台東也有如此夢幻場景！",
//    "createdTime": NSDate().timeIntervalSince1970,
//    "id": document.documentID,
//    "category": "Travel"
// ]
