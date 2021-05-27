//
//  OptionViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import UIKit

class OptionViewModel {

    var option: Option
    
    var onDead: (() -> Void)?

    init(model option: Option) {
        self.option = option
    }

//    var optionTime: OptionTime {
//        get {
//            return option.optionTime ?? OptionTime(year: 2021, month: 10, day: 10)
//        }
//    }

    var startTime: Int64 {
        get {
            return option.startTime
        }
    }


    var id: String {
        get {
            return option.id
        }
    }

    var endTime: Int64 {
        get {
            return option.endTime
        }
    }
//
//    var duration: Int {
//        get {
//            return option.duration
//        }
//    }

    func onTap(meeting: Meeting) {

        OptionManager.shared.deleteOption(option: option, meeting: meeting) { [weak self] result in

            switch result {

            case .success(let optionID):

                print(optionID)
                self?.onDead?()

            case .failure(let error):

                print("optionDeleted.failure: \(error)")
            }
        }
    }
}
