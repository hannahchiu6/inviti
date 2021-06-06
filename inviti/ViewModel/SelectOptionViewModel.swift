//
//  SelectVMController.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import JKCalendar

class SelectOptionViewModel {

    let optionViewModels = Box([OptionViewModel]())

    var optionViewModel = OptionViewModel(model: Option(id: "", startTime: 0, endTime: 0, optionTime: OptionTime(year: 2021, month: 5, day: 5), duration: 60, selectedOptions: []))

    var option: Option = Option(id: "", startTime: 0, endTime: 0, optionTime: OptionTime(year: 2021, month: 5, day: 5), duration: 60, selectedOptions: [])

//    let selectedViewModels = Box([EventViewModel]())

    var refreshView: (() -> Void)?

    var onDead: (() -> Void)?

    var scrollToTop: (() -> Void)?

    var getOptionData: (() -> Void)?

    var onOptionCreated: (() -> Void)?

    var onOptionUpdated: (() -> Void)?

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
        self.refreshView?()
    }

    func onScrollToTop() {

        self.scrollToTop?()
    }

    func onStartTimeChanged(_ time: Int, date: Date) {
        let newHour = time * 3600000
        let newDate = date.millisecondsSince1970
        self.option.startTime = Int64(newHour) + newDate


    }

    func onEndTimeChanged(_ time: Int, date: Date) {
        self.option.duration = 60
        let newHour = (time * 3600000) + (self.option.duration * 60000)
        let newDate = date.millisecondsSince1970
        self.option.endTime = Int64(newHour) + newDate
    }

    func onOptionTimeChanged(_ date: Date) {
        self.option.optionTime = OptionTime(year: date.year, month: date.month, day: date.day)
    }

    func create(with meeting: Meeting, option: inout Option) {

        OptionManager.shared.createOption(option: &option, meeting: meeting) { result in

            switch result {

            case .success:

                print("onTapCreate option, success")
                self.onOptionCreated?()

            case .failure(let error):

                print("createOption.failure: \(error)")
            }
        }
    }

    func createWithEmptyData(with meetingID: String, option: inout Option) {

        OptionManager.shared.createEmptyOption(option: &option, meetingID: meetingID) { result in

            switch result {

            case .success:

                print("onTapCreate option, success")
                self.onOptionCreated?()

            case .failure(let error):

                print("createOption.failure: \(error)")
            }
        }
    }

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


    func createSelectedOption(in viewModels: [OptionViewModel], selectedDate: OptionTime) -> [OptionViewModel] {

        let newViewModels = viewModels.filter({ $0.option.optionTime == selectedDate })
        return newViewModels
    }

    func markSelectedDay(in viewModels: [OptionViewModel], selectedDate: OptionTime) -> [JKDay] {
        let newViewModels = viewModels.filter({ $0.option.optionTime == selectedDate})
        let marksDates = newViewModels.map ({
            Date.init(millis: $0.option.startTime)
        })

        let JDay = marksDates.map({
            JKDay(date: $0)
        })
        return JDay
    }

    func getOptionID(in viewModels: [OptionViewModel], index: Int) -> String {

        let newVMs = viewModels.filter({ Int(Date.hourFormatter.string(from: Date(millis: $0.option.startTime))) == index})

        let theVM = newVMs.first(where: { Int(Date.hourFormatter.string(from: Date(millis: $0.option.startTime))) == index})

        if index == 0 {

            return viewModels[index].id
            
        } else {

            return theVM!.id
        }

    }

    
    func onTap(with index: Int, meeting: Meeting) {
        optionViewModels.value[index].onTap(meeting: meeting)
    }

    func onEmptyTap(_ optionID: String, meetingID: String) {
        OptionManager.shared.deleteEmptyOption(optionID: optionID, meetingID: meetingID) { [weak self] result in

            switch result {

            case .success( _):
                
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
