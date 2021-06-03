//
//  VotingViewModel .swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//
//  swiftlint:disable force_unwrapping inclusive_language closure_end_indentation

import Foundation
import Firebase

class VotingViewModel {

    var voteViewModels = Box([VoteViewModel]())

    var optionViewModels = Box([OptionViewModel]())

    var meetingViewModels = Box([MeetingViewModel]())

    var voteViewModel = VoteViewModel(model: SelectedOption(isSelected: false, selectedUser: ""))

    var optionViewModel = OptionViewModel(model: Option(id: "", startTime: 0, endTime: 0, optionTime: nil, duration: 0, selectedOptions: []))

    var meetingViewModel = MeetingViewModel(model: Meeting(id: "", owner: SimpleUser(id: "", email: "", image: ""), createdTime: 0, subject: nil, location: nil, notes: nil, image: nil, singleMeeting: false, hiddenMeeting: false, deadlineMeeting: false, participants: nil, numOfParticipants: nil, deadlineTag: nil))

    var option: Option = Option(id: "", startTime: 0, endTime: 0, optionTime: nil, duration: 0, selectedOptions: [])

    var meeting: Meeting = Meeting(id: "", owner: SimpleUser(id: "", email: "", image: ""), createdTime: 0, subject: nil, location: nil, notes: nil, image: nil, singleMeeting: false, hiddenMeeting: false, deadlineMeeting: false, participants: nil, numOfParticipants: nil, deadlineTag: nil)

    var selectedOption: SelectedOption = SelectedOption(isSelected: false, selectedUser: "")

    var refreshView: (() -> Void)?

    var onDead: (() -> Void)?

    var scrollToTop: (() -> Void)?

    var getSelectedOptionData: (() -> Void)?

    var onSelectedOptionCreated: (() -> Void)?

    var onSelectedOptionUpdated: (() -> Void)?

    func onVotingChanged(_ bool: Bool) {
        self.selectedOption.isSelected = bool
    }

    func onSelectedUserAdded(_ selectedUser: String) {
        self.selectedOption.selectedUser = selectedUser
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

            case .failure(let error):

                print("fetchData.failure: \(error)")
            }
        }
    }

    func fetchVoteForYes(meetingID: String) {
        VoteManager.shared.fetchVoteForYes(meetingID: meetingID) { [weak self] result in

            switch result {

            case .success(let options):

                self?.setOptions(options)

            case .failure(let error):

                print("fetchData.failure: \(error)")
            }
        }
    }

    func fetchMeetingPackage() {

        NetworkManager.shared.fetchMeetingsPackage { [weak self] result in

            switch result {

            case .success(let meetings):

                self?.setMeetings(meetings)

            case .failure(let error):

                print("fetchData.failure: \(error)")
            }
        }
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

    func convertMeetingsToViewModels(from meetings: [Meeting]) -> [MeetingViewModel] {
        var viewModels = [MeetingViewModel]()
        for meeting in meetings {
            let viewModel = MeetingViewModel(model: meeting)
            viewModels.append(viewModel)
        }
        return viewModels
    }

    func setMeetings(_ meetings: [Meeting]) {
        meetingViewModels.value = convertMeetingsToViewModels(from: meetings)
    }

    func fetchData(optionID: String, meetingID: String) {

        VoteManager.shared.fetchSelectedOptions(optionID: optionID, meetingID: meetingID) { [weak self] result in

            switch result {

            case .success(let selectedOptions):

                self?.setSelectedOptions(selectedOptions)

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

    func onTap(with index: Int, option: Option, meeting: Meeting) {
        voteViewModels.value[index].onTap(option: option, meeting: meeting)
    }

    func onEmptyTap(_ optionID: String, meetingID: String, selectedOptionID: String) {
        VoteManager.shared.deleteEmptySelectedOption(selectedOptionID: selectedOptionID, optionID: optionID, meetingID: meetingID){ [weak self] result in

            switch result {

            case .success(let selectedOptionID):

                print(selectedOptionID)
                self?.onDead?()

            case .failure(let error):

                print("fetchData.failure: \(error)")
            }
        }
    }

    func convertSelectedOptionsToViewModels(from selectedOptions: [SelectedOption]) -> [VoteViewModel] {

        var viewModels = [VoteViewModel]()
        for selectedOption in selectedOptions {
            let viewModel = VoteViewModel(model: selectedOption)
            viewModels.append(viewModel)
        }
        return viewModels
    }

    func setSelectedOptions(_ selectedOptions: [SelectedOption]) {
        voteViewModels.value = convertSelectedOptionsToViewModels(from: selectedOptions)
    }

    func onTimeChanged(_ time: Int64) -> String {
        let newTime = Date.timeFormatter.string(from: Date.init(millis: time))

        return newTime
    }

}
