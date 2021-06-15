//
//  MainViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation

class MainViewModel {

    var meetingViewModels = Box([MeetingViewModel]())

    var hostMeetingViewModels = Box([MeetingViewModel]())

    var meeting: Meeting = Meeting(id: "",  numberForSearch: "", ownerAppleID: "", createdTime: 0, subject: nil, location: nil, notes: nil, image: nil, singleMeeting: false, hiddenMeeting: false, deadlineMeeting: false, participants: nil, numOfParticipants: nil, deadlineTag: nil)

    var userViewModels = Box([UserViewModel]())

    var user: User = User(id: "", email: "", name: "", image: "", phone: "", address: "", calendarType: "", numOfMeetings: 0, numberForSearch: "")


    var refreshView: (() -> Void)?

    var scrollToTop: (() -> Void)?

    var onDead: (() -> Void)?

    var isVoted: Bool = false

    var onMeetingFetched: ((Meeting) -> Void)?

    func fetchData() {

        NetworkManager.shared.fetchMeetings { [weak self] result in

            switch result {

            case .success(let meetings):

                self?.setMeetings(meetings)

            case .failure(let error):

                print("fetchData.failure: \(error)")
            }
        }
    }

    func fetchHostedData() {

        NetworkManager.shared.fetchHostedMeetings { [weak self] result in

            switch result {

            case .success(let meetings):

                self?.setMeetings(meetings)

            case .failure(let error):

                print("fetchData.failure: \(error)")
            }
        }
    }

    func fetchMyData() {

        NetworkManager.shared.fetchHostedMeetings { [weak self] result in

            switch result {

            case .success(let meetings):

                self?.setHostMeetings(meetings)

            case .failure(let error):

                print("fetchData.failure: \(error)")
            }
        }
    }
    func checkIfVoted(options: [Option]) {

        VoteManager.shared.checkIfOptionVoted(options: options) { [weak self] result in

            switch result {

            case .success(let options):

                if options.isEmpty {

                    self?.isVoted = false

                } else {

                    self?.isVoted = true
                }

            case .failure(let error):

                print("fetchData.failure: \(error)")
            }

        }
    }

    func fetchParticipatedData() {

        NetworkManager.shared.fetchParticipatedMeetings { [weak self] result in

            switch result {

            case .success(let meetings):

                self?.setMeetings(meetings)

            case .failure(let error):

                print("fetchData.failure: \(error)")
            }
        }
    }


//    func fetchParticipantsProfile(userIDs: [String]) {
//
//        NetworkManager.shared.fetchProfileUser(userIDs: userIDs) { [weak self] result in
//
//            switch result {
//
//            case .success(let users):
//
//                self?.setUsers(users)
//
//            case .failure(let error):
//
//                print("fetchData.failure: \(error)")
//            }
//        }
//    }

    func onRefresh() {
       
        self.refreshView?()
    }

    func onScrollToTop() {

        self.scrollToTop?()
    }

    func onTap(withIndex index: Int) {

        meetingViewModels.value[index].onTap()
    }

    func onEmptyTap(_ meetingID: String) {

        NetworkManager.shared.deleteOneMeeting(meetingID: meetingID) { [weak self] result in

            switch result {

            case .success( _):

                self?.onDead?()

            case .failure(let error):

                print("deleteMeeting.failure: \(error)")
            }
        }
    }

    var onMeetingUpdated: (() -> Void)?

    func update(with meeting: Meeting) {

        NetworkManager.shared.updateMeeting(meetingID: meeting.id, meeting: meeting) { result in

            switch result {

            case .success:

                print("onTapCreate meeting, success")
                self.onMeetingUpdated?()

            case .failure(let error):

                print("create meetings failure: \(error)")
            }
        }

    }


    func convertMeetingsToViewModels(from meetings: [Meeting]) -> [MeetingViewModel] {
        var viewModels = [MeetingViewModel]()

        let newMeetings = meetings.sorted(by: { $0.createdTime > $1.createdTime })

        for meeting in newMeetings {

            let viewModel = MeetingViewModel(model: meeting)
            viewModels.append(viewModel)
        }
        return viewModels
    }

    func setMeetings(_ meetings: [Meeting]) {
        meetingViewModels.value = convertMeetingsToViewModels(from: meetings)
    }


    func convertUsersToViewModels(from users: [User]) -> [UserViewModel] {
        var viewModels = [UserViewModel]()

        for user in users {

            let viewModel = UserViewModel(model: user)
            viewModels.append(viewModel)
        }
        return viewModels
    }

    func setUsers(_ users: [User]) {
        userViewModels.value = convertUsersToViewModels(from: users)
    }

    func setHostMeetings(_ meetings: [Meeting]) {
        hostMeetingViewModels.value = convertMeetingsToViewModels(from: meetings)
    }

    var onMeetingCreated: (() -> Void)?

    func create(with meeting: inout Meeting) {
        NetworkManager.shared.createMeeting(meeting: &meeting) { result in

            switch result {

            case .success:

                print("onTapCreate meeting, success")
                self.onMeetingCreated?()

            case .failure(let error):

                print("createMeeting.failure: \(error)")
            }
        }
    }

}
