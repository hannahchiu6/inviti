//
//  MainViewModel.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation

class MainVMController {

    let meetingViewModels = Box([MeetingViewModel]())

    var refreshView: (() -> Void)?

    var scrollToTop: (() -> Void)?

    var onMeetingUpdated: (() -> Void)?

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

    func fetchNewData() {

        NetworkManager.shared.fetchNewMeetings { [weak self] result in

            switch result {

            case .success(let meetings):

                self?.setMeetings(meetings)

            case .failure(let error):

                print("fetchData.failure: \(error)")
            }
        }
    }

    func fetchOldData() {

        NetworkManager.shared.fetchOldMeetings { [weak self] result in

            switch result {

            case .success(let meetings):

                self?.setMeetings(meetings)

            case .failure(let error):

                print("fetchData.failure: \(error)")
            }
        }
    }

    func updateMeetingData(with meeting: Meeting) {

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

    func onRefresh() {
        // maybe do something
        self.refreshView?()
    }

    func onScrollToTop() {

        self.scrollToTop?()
    }

    func onTap(withIndex index: Int) {
        meetingViewModels.value[index].onTap()
    }

    func convertMeetingsToViewModels(from meetings: [Meeting]) -> [MeetingViewModel] {
        var viewModels = [MeetingViewModel]()
        for meeting in meetings {
            let viewModel = MeetingViewModel(model: meeting)
            viewModels.append(viewModel)
        }
        return viewModels
    }

    func setMeetings(_ meetings: [Meeting]) {
        meetingViewModels.value = convertMeetingsToViewModels(from: meetings)
    }
}
