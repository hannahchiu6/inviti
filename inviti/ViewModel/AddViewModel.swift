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

    var userViewModels = Box([UserViewModel]())

    var meetingViewModel: MeetingViewModel?

    var userUID = UserDefaults.standard.string(forKey: UserDefaults.Keys.uid.rawValue) ?? ""

    var meeting: Meeting = Meeting(id: "", numberForSearch: "", ownerAppleID: "", createdTime: 0, subject: nil, location: nil, notes: nil, image: nil, singleMeeting: false, hiddenMeeting: false, deadlineMeeting: false, participants: nil, numOfParticipants: nil, deadlineTag: nil)

    var refreshView: (() -> Void)?

    var onMeetingFetched: ((Meeting) -> Void)?

    func fetchData(meetingID: String) {

        NetworkManager.shared.fetchOneMeeting(meetingID: meetingID) { [weak self] result in

            switch result {

            case .success(let meeting):

                self?.meeting = meeting

            case .failure(let error):

                print("fetch meeting data failure: \(error)")
            }
        }
    }


    func updateParticipantData(meetingID: String) {

        let db = Firestore.firestore()

            db.collection("meetings")
                .document(meetingID)
                .updateData([
                    "participants": FieldValue.arrayUnion([userUID])
                ]) { err in

                    if err != nil {
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

                    if err != nil {
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
