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
        owner: (UserManager.shared.user?.id)!,
        createdTime: 1,
        subject: "",
        location: "",
        notes: "",
        image: "",
//        options: Option,
        singleMeeting: false,
        hiddenMeeting: false,
        deadlineMeeting: false,
//        askInfo: AskInfo,
        participants: ["aaa"],
        numOfParticipants: 1,
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

    var onCreated: (() -> Void)?

    func onTapCreate() {

        if hasUserInMeeting() {
            print("has user in meeting...")
            create() // MARK: check which function this call is

        } else {
            print("login...")
            UserManager.shared.login() { [weak self] result in
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
                self.onCreated?()

            case .failure(let error):

                print("createMeeting.failure: \(error)")
            }
        }
    }

    func create(with user: User? = nil) {

        if let user = user {
            meeting.owner = user.id!
        }

        create(with: &meeting) // MARK: check which function this call is
    }

    func hasUserInMeeting() -> Bool {
        return meeting.owner != nil
    }
}
