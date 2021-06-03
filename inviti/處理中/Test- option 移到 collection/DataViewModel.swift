////
////  OptionViewModel.swift
////  inviti
////
////  Created by Hannah.C on 20.05.21.
////
//
//import UIKit
//
//class DataViewModel {
//
//    var selectedData: SelectedData
//    
//    var onDead: (() -> Void)?
//
//    init(model selectedData: SelectedData) {
//        self.selectedData = selectedData
//    }
//
//    var optionTime: OptionTime {
//        get {
//            return selectedData.optionTime ?? OptionTime(year: 2021, month: 10, day: 10)
//        }
//    }
//
//    var startTime: Int64 {
//        get {
//            return selectedData.startTime
//        }
//    }
//
//
//    var id: String {
//        get {
//            return selectedData.id
//        }
//    }
//
//    var endTime: Int64 {
//        get {
//            return selectedData.endTime
//        }
//    }
//
//    var duration: Int {
//        get {
//            return selectedData.duration
//        }
//    }
//
//    func onTap() {
//
//        SelectedDataManager.shared.deleteSelectedData(selectedData: selectedData) { [weak self] result in
//
//            switch result {
//
//            case .success(let optionID):
//
//                print(optionID)
//                self?.onDead?()
//
//            case .failure(let error):
//
//                print("optionDeleted.failure: \(error)")
//            }
//        }
//    }
//}
