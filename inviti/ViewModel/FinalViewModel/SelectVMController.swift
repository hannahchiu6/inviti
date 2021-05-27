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

    var scrollToTop: (() -> Void)?

    func fetchData(meeting: Meeting) {
        
        OptionManager.shared.fetchOptions(meeting: meeting) { [weak self] result in

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

    func createTimeData(in viewModels: [OptionViewModel]) -> [JKDay] {
        let optionDates = viewModels.map({
            Date.init(millis: $0.option.startTime)
        })

        let JDays = optionDates.map({
            JKDay(date: $0)
        })
        return JDays
    }

    func onTap(with index: Int, meeting: Meeting) {
        optionViewModels.value[index].onTap(meeting: meeting)
    }

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
