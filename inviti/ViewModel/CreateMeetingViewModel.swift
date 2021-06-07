//
//  CreateMeetingViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase

class CreateMeetingViewModel {

    var meetingViewModels = Box([MeetingViewModel]())

    var meetingViewModel = MeetingViewModel(model: Meeting(
        id: "",
//        owner: (UserManager.shared.user?.id)!,
        owner: SimpleUser(id: "", email: "moon2021@gmail.com", image: "https://lh3.googleusercontent.com/proxy/u2icusi6aMz0vKbu8L5F3tEEadtx3DVcJD_Ya_lubYz6MH4A9a6KL0CFvAeeaDWJ9sIr44RQz8Qy3zJE72Cq1rPUZeZr4FLxXGRkLdNBs2-VxhpIVSY6JnPnjYzLp0Q"), ownerAppleID: "",
        createdTime: 0,
        subject: "",
        location: "",
        notes: "",
        image: "https://500px.com/static/media/editors8@1x.126c6fb9.png",
        singleMeeting: false,
        hiddenMeeting: false,
        deadlineMeeting: false,
//        askInfo: AskInfo,
        participants: ["aaa"],
        numOfParticipants: 0,
        deadlineTag: 0
    ))

    var meeting: Meeting = Meeting(
        id: "",
//        owner: (UserManager.shared.user?.id)!,
        owner: SimpleUser(id: "", email: "moon2021@gmail.com", image: "https://lh3.googleusercontent.com/proxy/u2icusi6aMz0vKbu8L5F3tEEadtx3DVcJD_Ya_lubYz6MH4A9a6KL0CFvAeeaDWJ9sIr44RQz8Qy3zJE72Cq1rPUZeZr4FLxXGRkLdNBs2-VxhpIVSY6JnPnjYzLp0Q"), ownerAppleID: "",
        createdTime: 0,
        subject: "",
        location: "",
        notes: "",
        image: "https://500px.com/static/media/editors8@1x.126c6fb9.png",
        singleMeeting: false,
        hiddenMeeting: false,
        deadlineMeeting: false,
//        askInfo: AskInfo,
        participants: ["aaa"],
        numOfParticipants: 0,
        deadlineTag: 0
    )

    var onSubjectAdded: ((String) -> Void)?

    func onIDChanged(_ id: String) {
        self.meeting.id = id
    }

    func onSubjectChanged(text subject: String) {
        self.meeting.subject = subject
        self.onSubjectAdded?(subject)
    }

    func onNotesChanged(text notes: String) {
        self.meeting.notes = notes
    }

    func onLocationChanged(text location: String) {
        self.meeting.location = location
    }

    func meetingDeadlineChanged(_ bool: Bool) {
        self.meeting.deadlineMeeting = bool
    }

    func meetingSingleChanged(_ bool: Bool) {
        self.meeting.singleMeeting = bool
    }

    func meetingHiddenChanged(_ bool: Bool) {
        self.meeting.hiddenMeeting = bool
    }

    func onDeadlineTagChanged(_ day: Int) {
        self.meeting.deadlineTag = day
    }

    var onMeetingCreated: (() -> Void)?

    var onMeetingIDGet: ((String) -> Void)?

    var refreshView: (() -> Void)?

    var scrollToTop: (() -> Void)?

    var onMeetingFetched: ((Meeting) -> Void)?

    func fetchOneMeeitngData(meetingID: String) {

        NetworkManager.shared.fetchOneMeeting(meetingID: meetingID) { [weak self] result in

            switch result {

            case .success(let meeting):

                self?.setMeeting(meeting)

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

    func onTap(withIndex index: Int) {
        meetingViewModels.value[index].onTap()
    }

    var onDead: (() -> Void)?

    func onOneTap(meetingID: String) {
        NetworkManager.shared.deleteOneMeeting(meetingID: meetingID) { [weak self] result in

            switch result {

            case .success(let meetingID):

                print(meetingID)
                self?.onDead?()

            case .failure(let error):

                print("publishMeeting.failure: \(error)")
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

    func convertMeetingToViewModels(from meeting: Meeting) -> [MeetingViewModel] {
        var viewModels = [MeetingViewModel]()
        let viewModel = MeetingViewModel(model: meeting)
        viewModels.append(viewModel)

        return viewModels
    }

    func setMeeting(_ meeting: Meeting) {
        meetingViewModels.value = convertMeetingToViewModels(from: meeting)
    }


    func onOneMeetingGet(from meeting: Meeting) -> MeetingViewModel {

        let viewModel = MeetingViewModel(model: meeting)

        return viewModel
    }

//    func onTapCreate() {
//
//        if hasUserInMeeting() {
//            print("has user in meeting...")
//            create() // MARK: check which function this call is
//
//        } else {
//            print("login...")
//            UserManager.shared.didLoginBefore { [weak self] result in
//                // MARK: - put your id into login function
//                switch result {
//
//                case .success(let user):
//
//                    print("login success")
//                    self?.create(with: user) // MARK: check which function this call is
//
//                case .failure(let error):
//
//                    print("login.failure: \(error)")
//                }
//
//            }
//        }
//    }


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

        create(with: &meeting) // MARK: check which function this call is
    }

    func hasUserInMeeting() -> Bool {
        return meeting.owner != nil
    }

}
