//
//  VotingViewModel .swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase

class VotingViewModel {
    
    var optionViewModels = Box([OptionViewModel]())
    
    var meetingViewModels = Box([MeetingViewModel]())
    
    var userBox = Box(UserViewModel(model: User(id: "", email: "", name: "", image: "", phone: "", address: "", calendarType: "", numOfMeetings: 0, events: [], notification: [], numberForSearch: "")))
    
    var voteViewModel = VoteViewModel(model: SelectedOption(isSelected: false, selectedUser: ""))
    
    var meeting: Meeting = Meeting(
        id: "",
        numberForSearch: "",
        ownerAppleID: UserDefaults.standard.value(forKey: UserDefaults.Keys.uid.rawValue) as? String ?? "",
        createdTime: 0,
        subject: "",
        location: "",
        notes: "",
        image: "https://500px.com/static/media/editors8@1x.126c6fb9.png",
        singleMeeting: false,
        hiddenMeeting: false,
        deadlineMeeting: false,
        participants: [],
        numOfParticipants: 0,
        deadlineTag: 0
    )
    
    var option: Option = Option(id: "", startTime: 0, endTime: 0, optionTime: nil, duration: 0, selectedOptions: [])
    
    var options: [Option] = [Option(id: "", startTime: 0, endTime: 0, optionTime: nil, duration: 0, selectedOptions: [])]
    
    var refreshView: (() -> Void)?
    
    var userUID = UserDefaults.standard.string(forKey: UserDefaults.Keys.uid.rawValue) ?? ""
    
    var onDead: (() -> Void)?
    
    var user: User = User(id: "", email: "", name: "", image: "", phone: "", address: "", calendarType: "", numOfMeetings: 0, events: [], notification: [], numberForSearch: "")
    
    var isVoted: Bool = false
    
    var multipleOptions: (() -> Void)?
    
    var getSelectedOptionData: (() -> Void)?
    
    var onSelectedOptionCreated: (() -> Void)?
    
    var onSelectedOptionUpdated: (() -> Void)?
    
    func onselectedOptionChanged(_ selectedOptions: [String]?, index: Int) {
        
        self.options[index].selectedOptions = selectedOptions
    }
    
    func onMeetingOptionChanged(_ option: FinalOption) {
        self.meeting.finalOption = option
    }
    
    func fetchUserData(userID: String) {
        
        UserManager.shared.fetchOneUser(userID: userID) { [weak self] result in
            
            switch result {
            
            case .success(let user):
                
                self?.setUser(user)
                
            case .failure(let error):
                
                print("fetchData.failure: \(error)")
            }
        }
    }
    
    func fetchUserForHost(userID: String) {
        
        UserManager.shared.fetchHostUser(userID: userID) { [weak self] result in
            
            switch result {
            
            case .success(let user):
                
                self?.setUser(user)
                
                self?.user = user
                
            case .failure(let error):
                
                print("fetchData.failure: \(error)")
            }
        }
    }
    
    func fetchMeetingData() {
        
        NetworkManager.shared.fetchMeetings { [weak self] result in
            
            switch result {
            
            case .success(let meetings):
                
                self?.setMeetings(meetings)
                
            case .failure(let error):
                
                print("fetchData.failure: \(error)")
            }
        }
    }
    
    func fetchOptionData(meetingID: String) {
        OptionManager.shared.fetchOptions(meetingID: meetingID) { [weak self] result in
            
            switch result {
            
            case .success(let options):
                
                self?.setOptions(options)
                self?.options = options

                if !options.isEmpty {

                    guard let selectedOptions = options[0].selectedOptions else { return }

                    if selectedOptions.isEmpty {

                        self?.isVoted = false

                    } else {

                        self?.isVoted = true
                    }
                }
                
            case .failure(let error):
                
                print("fetchData.failure: \(error)")
            }
        }
    }
    
    func getOptionsIDs(optionVMs: [OptionViewModel]) -> [String] {
        
        let newVM = optionViewModels.value
        
        let optionIDs = newVM.map({ $0.id })
        
        return optionIDs
    }
    
//    func checkIfAnyVoted(meetingID: String) {
//
//        VoteManager.shared.checkIfVoted(meetingID: meetingID) { [weak self] result in
//
//            switch result {
//
//            case .success(let options):
//
//                if options.isEmpty {
//
//                    self?.isVoted = true
//
//                } else {
//
//                    self?.isVoted = false
//                }
//
//            case .failure(let error):
//
//                print("fetchData.failure: \(error)")
//            }
//
//        }
//    }
    
    func checkSingleVote(meeting: Meeting) {
        if meeting.singleMeeting {
            self.onMultipleOptions()
        }
    }

//    func isVoted(_ selectedOptions: [VoteViewModel]) -> Bool {
//
//        if selectedOptions.isEmpty {
//
//            return true
//
//        } else {
//
//            return false
//        }
//    }
    
    func convertOptionsToViewModels(from options: [Option]) -> [OptionViewModel] {
        
        var viewModels = [OptionViewModel]()
        for option in options {
            let viewModel = OptionViewModel(model: option)
            viewModels.append(viewModel)
        }
        if option.selectedOptions != nil {
            
            let newViewModels = self.sortVotes(vms: viewModels)
            
            return newViewModels
        }
        
        return viewModels
    }
    
    func setOptions(_ options: [Option]) {
        optionViewModels.value = convertOptionsToViewModels(from: options)
    }
    
    var onMeetingUpdated: (() -> Void)?
    
    func updateCloseStatus(with meetingID: String) {
        
        guard let finalOption = self.meeting.finalOption else { return }
        NetworkManager.shared.updateMeetingClose(meetingID: meetingID, finalOption: finalOption)
    }
    
    func onRefresh() {
        self.refreshView?()
    }
    
    func onMultipleOptions() {
        self.multipleOptions?()
    }

    func create(with meeting: Meeting, option: Option, selectedOption: inout SelectedOption) {
        
        VoteManager.shared.createSelectedOption(selectedOption: &selectedOption, meeting: meeting, option: option) { result in
            
            switch result {
            
            case .success:
                
                print("onTapCreate option, success")

                self.onSelectedOptionCreated?()
                
            case .failure(let error):
                
                print("createOption.failure: \(error)")
            }
        }
    }
    
    func createVotedData(with options: [Option], meeting: Meeting, selectedOption: inout SelectedOption) {
        
        for option in options {
            VoteManager.shared.createSelectedOption(selectedOption: &selectedOption, meeting: meeting, option: option) { result in
                switch result {
                
                case .success:
                    print("onTapCreate option, success")
                    self.onSelectedOptionCreated?()
                    
                case .failure(let error):
                    
                    print("createOption.failure: \(error)")
                }
            }
        }
    }
    
    func updateVotedOption(with meetingID: String, optionIndex: [Int]?) {
        
        if let index = optionIndex {
            
            for i in index {
                
                OptionManager.shared.updateVotedOption(option: options[i], meetingID: meetingID) { result in
                    
                    switch result {
                    
                    case .success:
                        
                        print("onTapCreate option, success")
                        
                    case .failure(let error):
                        
                        print("createOption.failure: \(error)")
                    }
                }
            }
        }
    }
    
    func createWithEmptyData(with optionID: String, meetingID: String, selectedOption: inout SelectedOption) {
        
        VoteManager.shared.createEmptySelectedOption(selectedOption: &selectedOption, meetingID: meetingID, optionID: optionID) { result in
            switch result {
            case .success:
                print("onTapCreate option, success")
                self.onSelectedOptionCreated?()
                
            case .failure(let error):
                
                print("createOption.failure: \(error)")
            }
        }
    }
    
    func onEmptyTap(_ optionID: String, meetingID: String, selectedOptionID: String) {
        VoteManager.shared.deleteEmptySelectedOption(selectedOptionID: selectedOptionID, optionID: optionID, meetingID: meetingID) { [weak self] result in
            
            switch result {
            
            case .success:
                
                self?.onDead?()
                
            case .failure(let error):
                
                print("deleteData.failure: \(error)")
            }
        }
    }
    
    func onTimeChanged(_ time: Int64) -> String {
        let newTime = Date.timeFormatter.string(from: Date.init(millis: time))
        
        return newTime
    }
    
    func sortVotes(vms: [OptionViewModel]) -> [OptionViewModel] {
        
        let sorted = vms.sorted { $0.selectedOptions?.count ?? 0 > $1.selectedOptions?.count ?? 0 }
        
        return sorted
    }
    
    func fetchOneMeeitngData(meetingID: String) {
        
        NetworkManager.shared.fetchOneMeeting(meetingID: meetingID) { [weak self] result in
            
            switch result {
            
            case .success(let meeting):
                
                self?.setMeeting(meeting)
                self?.checkSingleVote(meeting: meeting)
            case .failure(let error):
                
                print("fetch one meeting data failure: \(error)")
            }
        }
    }
    
    func setMeetings(_ meetings: [Meeting]) {
        meetingViewModels.value = convertMeetingsToViewModels(from: meetings)
    }
    
    func convertMeetingsToViewModels(from meetings: [Meeting]) -> [MeetingViewModel] {
        var viewModels = [MeetingViewModel]()
        let viewModel = MeetingViewModel(model: meeting)
        viewModels.append(viewModel)
        
        return viewModels
    }
    
    func setMeeting(_ meeting: Meeting) {
        
        if !meetingViewModels.value.isEmpty {
            meetingViewModels.value[0] = convertMeetingToViewModel(meeting)
        }
    }
    
    func convertMeetingToViewModel(_ meeting: Meeting) -> MeetingViewModel {
        
        let viewModel = MeetingViewModel(model: meeting)
        return viewModel
    }
    
    func convertUserToViewModel(from user: User) -> UserViewModel {
        
        let viewModel = UserViewModel(model: user)
        
        return viewModel
    }
    
    func setUser(_ user: User) {
        userBox.value = convertUserToViewModel(from: user)
    }

}
