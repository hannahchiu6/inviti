////
////  CreateDataViewModel.swift
////  inviti
////
////  Created by Hannah.C on 20.05.21.
////
//
//import Foundation
//import Firebase
//import FirebaseFirestoreSwift
//
//class CreateDataViewModel {
//
//    var selectedData: SelectedData = SelectedData(startTime: 0, endTime: 0, optionTime: OptionTime(year: 2021, month: 5, day: 5), duration: 60)
//
////    func onDurationChanged(time duration: Int) {
////        self.option.duration = duration
////    }
//
//    func onStartTimeChanged(time startTime: Int) {
//
//        self.selectedData.startTime = Int64(startTime)
//    }
//
//    func onEndTimeChanged(time endTime: Int) {
//        self.selectedData.endTime = Int64(endTime)
//    }
//
//
//    func onOptionTimeChanged(date optionTime: OptionTime) {
//
//        self.selectedData.optionTime = optionTime
//
//    }
//
//    var onSelectedDataCreated: (() -> Void)?
//
////    func onTapCreate() {
////
////        if hasUserInMeeting() {
////            print("has user in meeting...")
////            create() // MARK: check which function this call is
////
////        } else {
////            print("login...")
////            SimpleManager.shared.login() { [weak self] result in
////                // MARK: - put your id into login function
////                switch result {
////
////                case .success(let user):
////
////                    print("login success")
////                    self?.create(with: user) // MARK: check which function this call is
////
////                case .failure(let error):
////
////                    print("login.failure: \(error)")
////                }
////
////            }
////        }
////    }
//
//    func create(with selectedData: inout SelectedData) {
//
//        SelectedDataManager.shared.createSelectedData(selectedData: &selectedData) { result in
//
//            switch result {
//
//            case .success:
//
//                print("onTapCreate option, success")
//                self.onSelectedDataCreated?()
//
//            case .failure(let error):
//
//                print("createOption.failure: \(error)")
//            }
//        }
//    }
//
////    func create(with user: SimpleUser? = nil) {
////
////        if let user = user {
////            option.owner = user
////        }
//
////        create(with: &meeting) // MARK: check which function this call is
////    }
//
////    func hasUserInMeeting() -> Bool {
////        return meeting.owner != nil
////    }
//}
