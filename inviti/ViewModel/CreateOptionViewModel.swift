//
//  CreateOptionViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase

class CreateOptionViewModel {

    let optionViewModel = SelectOptionViewModel()
    
    var option: Option = Option(id: "", startTime: 0, endTime: 0, optionTime: OptionTime(year: 2021, month: 5, day: 5), duration: 60)

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
    
    var onOptionCreated: (() -> Void)?
    
    var onOptionUpdated: (() -> Void)?
    
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
}
