//
//  VoteViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import UIKit

class VoteViewModel {
    
    var selectedOption: SelectedOption
    
    var onDead: (() -> Void)?
    
    init(model selectedOption: SelectedOption) {
        self.selectedOption = selectedOption
    }
    
    var isSelected: Bool? {
        get {
            return selectedOption.isSelected
        }
    }
    
    var selectedUser: String? {
        get {
            return selectedOption.selectedUser
        }
    }
    
    func onTap(option: Option, meeting: Meeting) {
        
        VoteManager.shared.deleteSelectedOption(selectedOption: selectedOption, option: option, meeting: meeting) { [weak self] result in
            
            switch result {
            
            case .success(let selectedOption):
                
                print(selectedOption)
                self?.onDead?()
                
            case .failure(let error):
                
                print("optionDeleted.failure: \(error)")
            }
        }
    }
    
    func onEmptyTapWith(selectedOptionID: String, optionID: String, meetingID: String) {
        
        VoteManager.shared.deleteEmptySelectedOption(selectedOptionID: selectedOptionID, optionID: optionID, meetingID: meetingID) { [weak self] result in
            
            switch result {
            
            case .success(let selectedOptionID):
                
                print(selectedOptionID)
                self?.onDead?()
                
            case .failure(let error):
                
                print("optionDeleted.failure: \(error)")
            }
        }
    }
}
