//
//  CreateViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase

class CreateViewModel {

    var meeting: Meeting = Meeting(
        id: "",
//        owner: (UserManager.shared.user?.id)!,
        owner: SimpleUser(id: "5gWVjg7xTHElu9p6Jkl1", email: "moon2021@gmail.com", image: "https://lh3.googleusercontent.com/proxy/u2icusi6aMz0vKbu8L5F3tEEadtx3DVcJD_Ya_lubYz6MH4A9a6KL0CFvAeeaDWJ9sIr44RQz8Qy3zJE72Cq1rPUZeZr4FLxXGRkLdNBs2-VxhpIVSY6JnPnjYzLp0Q"),
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


    func onSubjectChanged(text subject: String) {
        self.meeting.subject = subject
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

    func onTapCreate() {

        if hasUserInMeeting() {
            print("has user in meeting...")
            create() // MARK: check which function this call is

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

    func create(with meeting: inout Meeting) {
        NetworkManager.shared.createMeeting(meeting: &meeting) { result in

            switch result {

            case .success:

                print("onTapCreate, success")
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
