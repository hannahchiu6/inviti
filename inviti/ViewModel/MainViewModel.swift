//
//  MainViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation

class MainViewModel {

    var meetingViewModels = Box([MeetingViewModel]())

    var meeting: Meeting = Meeting(id: "", owner: SimpleUser(id: "", email: "", image: ""), ownerAppleID: "", createdTime: 0, subject: nil, location: nil, notes: nil, image: nil, singleMeeting: false, hiddenMeeting: false, deadlineMeeting: false, participants: nil, numOfParticipants: nil, deadlineTag: nil)

    var refreshView: (() -> Void)?

    var scrollToTop: (() -> Void)?

    var onDead: (() -> Void)?

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

//    func updateMeetingData(with meeting: Meeting) {
//
//        NetworkManager.shared.updateMeeting(meeting: meeting) { result in
//
//            switch result {
//
//            case .success:
//
//                print("onTapCreate meeting, success")
//                self.onMeetingUpdated?()
//
//            case .failure(let error):
//
//                print("createMeeting.failure: \(error)")
//            }
//        }
//
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

        NetworkManager.shared.updateMeeting(meeting: meeting) { result in

            switch result {

            case .success:

                print("onTapCreate meeting, success")
                self.onMeetingUpdated?()

            case .failure(let error):

                print("createMeeting.failure: \(error)")
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

    func onTapCreate() {

        if hasUserInMeeting() {
            print("has user in meeting...")
            create()

        } else {
            print("login...")
            SimpleManager.shared.login() { [weak self] result in
                // MARK: - put your id into login function
                switch result {

                case .success(let user):

                    print("login success")
                    self?.create(with: user) // MARK: check which function this call is

                case .failure(let error):

                    print("login.failure: \(error)")
                }

            }
        }
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

    func create(with user: SimpleUser? = nil) {

        if let user = user {
            meeting.owner = user
        }

        create(with: &meeting)
    }

    func hasUserInMeeting() -> Bool {
        return meeting.owner != nil
    }


}
