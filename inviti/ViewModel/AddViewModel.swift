//
//  AddViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AddViewModel {

    var meetingViewModel: MeetingViewModel?

    var userUID = UserDefaults.standard.value(forKey: "uid") as! String

    var meeting: Meeting = Meeting(id: "", owner: SimpleUser(id: "", email: "", image: ""), ownerAppleID: "", createdTime: 0, subject: nil, location: nil, notes: nil, image: nil, singleMeeting: false, hiddenMeeting: false, deadlineMeeting: false, participants: nil, numOfParticipants: nil, deadlineTag: nil)

    var meetingInfo: Meeting = Meeting(id: "", owner: SimpleUser(id: "", email: "", image: ""), ownerAppleID: "", createdTime: 0, subject: nil, location: nil, notes: nil, image: nil, singleMeeting: false, hiddenMeeting: false, deadlineMeeting: false, participants: nil, numOfParticipants: nil, deadlineTag: nil)

    var refreshView: (() -> Void)?

    var onMeetingFetched: ((Meeting) -> Void)?

    func fetchData(meetingID: String) {

        NetworkManager.shared.fetchOneMeeting(meetingID: meetingID) { [weak self] result in

            switch result {

            case .success(let meeting):

                self?.meetingInfo = meeting

            case .failure(let error):

                print("fetch meeting data failure: \(error)")
            }
        }
    }

    func updateParticipants() {

        let db = Firestore.firestore()

            db.collection("meetings")
                .document(meetingInfo.id)
                .updateData([
                    "participants": FieldValue.arrayUnion([userUID])
                ]) { err in

                if let err = err {
                    print("Failed to update participants")
                } else {
                    print("Participant ID has been updated!")
                }
        }

    }

    func addSearchParticipants(meetingID: String, text: String) {

        let db = Firestore.firestore()

            db.collection("meetings")
                .document(meetingID)
                .updateData([
                    "participants": FieldValue.arrayUnion([text])
                ]) { err in

                if let err = err {
                    print("Failed to update participants")

                } else {
                    print("Participant ID has been updated!")
                }
        }

    }



    func onRefresh() {
       
        self.refreshView?()
    }

    func convertMeetingsToViewModel(from meeting: Meeting) -> MeetingViewModel {

        let viewModel = MeetingViewModel(model: meeting)

        return viewModel
    }

    func setMeeting(_ meeting: Meeting) {
        meetingViewModel = convertMeetingsToViewModel(from: meeting)
    }
}
