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

    var subject: String {
        get {
            return meeting.subject ?? ""
        }
    }

    var numOfParticipants: Int {
        get {
            return meeting.numOfParticipants ?? 0
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

    var participants: [String] {
        get {
            return meeting.participants ?? []
        }
    }

//    var calendarType: String {
//        get {
//            switch article.category {
//            case "IU":
//                return UIColor.deepPurple
//            case "Beauty":
//                return UIColor.indigo
//            case "SchoolLife":
//                return UIColor.orange
//            case "Test":
//                return UIColor.red
//            default:
//                return UIColor.green
//            }
//        }
//    }

    var options: [Option]? {
        get {
            return meeting.options
        }
    }

    var owner: SimpleUser {
        get {
            return meeting.owner
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
