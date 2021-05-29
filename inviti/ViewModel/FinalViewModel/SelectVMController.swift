//
//  SelectVMController.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import JKCalendar

class SelectVMController {

    let optionViewModels = Box([OptionViewModel]())

//    let selectedViewModels = Box([EventViewModel]())

    var refreshView: (() -> Void)?

    var onDead: (() -> Void)?

    var scrollToTop: (() -> Void)?

    func fetchData(meetingID: String) {
        
        OptionManager.shared.fetchOptions(meetingID: meetingID) { [weak self] result in

            switch result {

            case .success(let options):

                self?.setOptions(options)

            case .failure(let error):

                print("fetchData.failure: \(error)")
            }
        }
    }


    func onRefresh() {
        // maybe do something
        self.refreshView?()
    }

    func onScrollToTop() {

        self.scrollToTop?()
    }

//    func createSelectedData(in viewModels: [OptionViewModel], selectedDate: String) -> [OptionViewModel] {
//        let oldViewModel = optionViewModels.value
//        var newViewModels = [OptionViewModel]()
//        newViewModels = oldViewModel.filter({$0.option.optionTime == Int(selectedDate)})
//        return newViewModels
//    }

    func createDateData(in viewModels: [OptionViewModel]) -> [OptionTime] {

        let theDays = viewModels.map({
            $0.optionTime
        })
        return theDays
    }

    func createTimeData(in viewModels: [OptionViewModel]) -> [Int?] {

        let theTime = viewModels.map({
                                        Int(Date.hourFormatter.string(from: Date(millis: $0.option.startTime)))})

        return theTime
    }

    func createHourData(in viewModels: [OptionViewModel]) -> [Int?] {

        let theTime = viewModels.map({
                                        Int(Date.hourFormatter.string(from: Date(millis: $0.option.startTime)))})
        return theTime
    }

    func createSelectedOption(in viewModels: [OptionViewModel], selectedDate: OptionTime) -> [OptionViewModel] {
        let oldViewModel = viewModels

        let newViewModels = oldViewModel.filter({$0.option.optionTime == selectedDate})
        return newViewModels
    }

    func getOptionID(in viewModels: [OptionViewModel], index: Int) -> String {

        let newVMs = viewModels.filter({ Int(Date.hourFormatter.string(from: Date(millis: $0.option.startTime))) == index})

        let theVM = newVMs.first(where: { Int(Date.hourFormatter.string(from: Date(millis: $0.option.startTime))) == index})

        return theVM!.id

    }

    
    func onTap(with index: Int, meeting: Meeting) {
        optionViewModels.value[index].onTap(meeting: meeting)
    }

    func onEmptyTap(_ optionID: String, meetingID: String) {
        OptionManager.shared.deleteEmptyOption(optionID: optionID, meetingID: meetingID){ [weak self] result in

            switch result {

            case .success(let optionID):

                print(optionID)
                self?.onDead?()

            case .failure(let error):

                print("fetchData.failure: \(error)")
            }
        }
    }

//    func onEmptyTap(with optionID: String, meetingID: String) {
//
//    }


    func convertOptionsToViewModels(from options: [Option]) -> [OptionViewModel] {

        var viewModels = [OptionViewModel]()
        for option in options {
            let viewModel = OptionViewModel(model: option)
            viewModels.append(viewModel)
        }
        return viewModels
    }

    func setOptions(_ options: [Option]) {
        optionViewModels.value = convertOptionsToViewModels(from: options)
    }
}
