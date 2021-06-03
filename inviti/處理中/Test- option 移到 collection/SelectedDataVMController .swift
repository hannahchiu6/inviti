////
////  SelectVMController.swift
////  inviti
////
////  Created by Hannah.C on 20.05.21.
////
//
//import Foundation
//import JKCalendar
//
//class SelectedDataController {
//
//    let selectedDataViewModels = Box([DataViewModel]())
//
////    let selectedViewModels = Box([EventViewModel]())
//
//    var refreshView: (() -> Void)?
//
//    var scrollToTop: (() -> Void)?
//
//    func fetchData(selectedData: SelectedData) {
//        
//        SelectedDataManager.shared.fetchSelectedData(selectedData: selectedData) { [weak self] result in
//
//            switch result {
//
//            case .success(let selectedDatas):
//
//                self?.setSelectedDatas(selectedDatas)
//
//            case .failure(let error):
//
//                print("fetchData.failure: \(error)")
//            }
//        }
//    }
//
//
//    func onRefresh() {
//        // maybe do something
//        self.refreshView?()
//    }
//
//    func onScrollToTop() {
//
//        self.scrollToTop?()
//    }
//
////    func createSelectedData(in viewModels: [OptionViewModel], selectedDate: String) -> [OptionViewModel] {
////        let oldViewModel = optionViewModels.value
////        var newViewModels = [OptionViewModel]()
////        newViewModels = oldViewModel.filter({$0.option.optionTime == Int(selectedDate)})
////        return newViewModels
////    }
//
//    func createTimeData(in viewModels: [DataViewModel]) -> [JKDay] {
//        let selectedDataDates = viewModels.map({
//            Date.init(millis: $0.selectedData.startTime)
//        })
//
//        let JDays = selectedDataDates.map({
//            JKDay(date: $0)
//        })
//        return JDays
//    }
//
//    func onTap(with index: Int, selectedData: SelectedData) {
//        selectedDataViewModels.value[index].onTap()
//    }
//
//    func convertSelectedDatasToViewModels(from selectedDatas: [SelectedData]) -> [DataViewModel] {
//
//        var viewModels = [DataViewModel]()
//        for selectedData in selectedDatas {
//            let viewModel = DataViewModel(model: selectedData)
//            viewModels.append(viewModel)
//        }
//        return viewModels
//    }
//
//    func setSelectedDatas(_ selectedDatas: [SelectedData]) {
//        selectedDataViewModels.value = convertSelectedDatasToViewModels(from: selectedDatas)
//    }
//}
