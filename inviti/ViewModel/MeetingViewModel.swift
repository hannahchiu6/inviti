//
//  MeetingViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import UIKit

class MeetingViewModel {

    var meeting: Meeting

    var onDead: (() -> Void)?

    init(model meeting: Meeting) {
        self.meeting = meeting
    }

    var id: String {
        get {
            return meeting.id
        }
    }

    var ownerAppleID: String {
        get {
            return meeting.ownerAppleID
        }
    }

    var subject: String? {
        get {
            return meeting.subject
        }
    }

    var location: String? {
        get {
            return meeting.location
        }
    }

    var numOfParticipants: Int? {
        get {
            return meeting.numOfParticipants
        }
    }

    var image: String? {
        get {
            return meeting.image
        }
    }

    var createdTime: Int64 {
        get {
           
            return meeting.createdTime
        }
    }

    var isClosed: Bool {
        get {

            return meeting.isClosed
        }
    }

    var singleMeeting: Bool {
        get {

            return meeting.singleMeeting
        }
    }

    var participants: [String]? {
        get {
            return meeting.participants
        }
    }

    var options: [Option]? {
        get {
            return meeting.options
        }
    }

//    var finalOption: Option? {
//        get {
//            return meeting.finalOption
//        }
//    }


    var finalOption: FinalOption? {
        get {
            return meeting.finalOption
        }
    }

    var numberForSearch: String {
        get {
            return meeting.numberForSearch
        }
    }

    func onTap() {
        NetworkManager.shared.deleteMeeting(meeting: meeting) { [weak self] result in

            switch result {

            case .success(let meetingID):

                print(meetingID)
                self?.onDead?()

            case .failure(let error):

                print("publishMeeting.failure: \(error)")
            }
        }
    }


}
