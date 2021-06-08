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
        ownerAppleID: UserDefaults.standard.value(forKey: UserDefaults.Keys.uid.rawValue) as! String,
        createdTime: 0,
        subject: "",
        location: "",
        notes: "",
        image: "https://500px.com/static/media/editors8@1x.126c6fb9.png",
        singleMeeting: false,
        hiddenMeeting: false,
        deadlineMeeting: false,
//        askInfo: AskInfo,
        participants: [],
        numOfParticipants: 0,
        deadlineTag: 0
    ))

    var meeting: Meeting = Meeting(
        id: "",
        ownerAppleID: UserDefaults.standard.value(forKey: UserDefaults.Keys.uid.rawValue) as! String,
        createdTime: 0,
        subject: "",
        location: "",
        notes: "",
        image: "https://500px.com/static/media/editors8@1x.126c6fb9.png",
        singleMeeting: false,
        hiddenMeeting: false,
        deadlineMeeting: false,
//        askInfo: AskInfo,
        participants: [],
        numOfParticipants: 0,
        deadlineTag: 0
    )

    var onSubjectAdded: ((String) -> Void)?

    func onIDChanged(_ id: String) {
        self.meeting.id = id
    }

    func onSubjectChanged(text subject: String) {
        self.meetingViewModel.meeting.subject = subject
        self.onSubjectAdded?(subject)
    }

    func onNotesChanged(text notes: String) {
        self.meetingViewModel.meeting.notes = notes
    }

    func onLocationChanged(text location: String) {
        self.meetingViewModel.meeting.location = location
    }

    func meetingDeadlineChanged(_ bool: Bool) {
        self.meetingViewModel.meeting.deadlineMeeting = bool
    }

    func meetingSingleChanged(_ bool: Bool) {
        self.meetingViewModel.meeting.singleMeeting = bool
    }

    func meetingHiddenChanged(_ bool: Bool) {
        self.meetingViewModel.meeting.hiddenMeeting = bool
    }

    func onDeadlineTagChanged(_ day: Int) {
        self.meetingViewModel.meeting.deadlineTag = day
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

        NetworkManager.shared.updateMeeting(meetingID: meeting.id, meeting: meeting) { result in

            switch result {

            case .success:

                print("onTapCreate meeting, success")
//                self.onMeetingUpdated?()

            case .failure(let error):

                print("createMeeting.failure: \(error)")
            }
        }

    }

    func updateSecond(meetingID: String) {

        NetworkManager.shared.updateMeeting(meetingID: meetingID, meeting: self.meetingViewModel.meeting) { result in

            switch result {

            case .success:

                print("onTapCreate meeting, success")
//                self.onMeetingUpdated?()

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

    func create(with userUID: String? = nil) {

        if let userUID = userUID {
            meeting.ownerAppleID = userUID
        }

        create(with: &meeting)
    }

    func hasUserInMeeting() -> Bool {
        return !meeting.ownerAppleID.isEmpty
    }

}
