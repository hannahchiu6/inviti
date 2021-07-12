//
//  UpdateNotificationVM.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import Foundation
import Firebase

class UpdateNotificationVM {
    
    var notificationViewModels = Box([NotificationViewModel]())
    
    var meetingViewModels = Box([MeetingViewModel]())
    
    var userBox = Box(UserViewModel(model: User(id: "", email: "", name: "", image: "", phone: "", address: "", calendarType: "", numOfMeetings: 0, events: [], notification: [], numberForSearch: "")))
    
    var notificationViewModel = NotificationViewModel(model: Notification(id: "", meetingID: "", eventID: "", participantID: "", createdTime: 0, type: "", image: ""))
    
    var userViewModel = UserViewModel(model: User(id: "", email: "", name: "", image: "", phone: "", address: "", calendarType: "", numOfMeetings: 0, events: [], notification: [], numberForSearch: ""))
    
    var notification: Notification = Notification(id: "", meetingID: "", eventID: "", participantID: "", createdTime: 0, type: "")
    
    var meetingViewModel = MeetingViewModel(model: Meeting(id: "", numberForSearch: "", ownerAppleID: "", createdTime: 0, subject: nil, location: nil, notes: nil, image: nil, singleMeeting: false, hiddenMeeting: false, deadlineMeeting: false, participants: nil, numOfParticipants: nil, deadlineTag: nil))
    
    var meeting: Meeting?
    
    var refreshView: (() -> Void)?
    
    var onDead: (() -> Void)?
    
    var onFetched: (() -> Void)?
    
    var onUserFetched: (() -> Void)?
    
    var onMeetingFetched: (() -> Void)?
    
    var user: User?
    
    func onMeetingFetched(with meeting: Meeting) {
        self.meetingViewModel.meeting = meeting
    }
    
    func onNotiTypeChanged(with type: String) {
        self.notification.type = type
    }
    
    func onNotiMeetingIDAdded(_ meetingID: String) {
        self.notification.meetingID = meetingID
    }
    
    func onImageChanged(_ image: String) {
        self.notification.image = image
    }
    
    func onNotiEventIDAdded(_ eventID: String) {
        self.notification.eventID = eventID
    }
    
    func onNotiParticipantIDAdded(_ participantID: String) {
        self.notification.participantID = participantID
    }
    
    func onSubjectChanged(_ subject: String) {
        self.notification.subject = subject
    }
    
    func onNameChanged(_ name: String) {
        self.notification.ownerName = name
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
    
    func fetchData() {
        
        NotificationManager.shared.addSnapshotNotifications { [weak self] result in
            
            switch result {
            
            case .success(let notifications):
                
                self?.setNotifications(notifications)
                
            case .failure(let error):
                
                print("fetchData.failure: \(error)")
            }
        }
    }
    
    func fetchUserData(userID: String) {
        
        UserManager.shared.fetchOneUser(userID: userID) { [weak self] result in
            
            switch result {
            
            case .success(let user):
                
                self?.setUser(user)
                
                self?.onUserFetched?()
                
            case .failure(let error):
                
                print("fetchData.failure: \(error)")
            }
        }
    }
    
    func fetchUserToSelf(userID: String) {
        
        UserManager.shared.fetchOneUser(userID: userID) { [weak self] result in
            
            switch result {
            
            case .success(let user):
                
                if let image = user.image,
                   let name = user.name {
                    
                    self?.onImageChanged(image)
                    
                    self?.onNameChanged(name)
                    
                }
                
            case .failure(let error):
                
                print("fetchData.failure: \(error)")
            }
        }
    }
    
    func fetchOneMeeitngData(meetingID: String) {
        
        NetworkManager.shared.fetchSearchResult(meetingID: meetingID) { [weak self] result in
            
            switch result {
            
            case .success(let meeting):
                
                self?.setMeeting(meeting)
                
                self?.onFetched?()
                
            case .failure(let error):
                
                print("fetchData.failure: \(error)")
            }
        }
    }
    
    func fetchSingleMeeitngData(meetingID: String) {
        
        NetworkManager.shared.fetchOneMeeting(meetingID: meetingID) { [weak self] result in
            
            switch result {
            
            case .success(let meeting):
                
                self?.setMeeting(meeting)
                
            case .failure(let error):
                
                print("fetchData.failure: \(error)")
            }
        }
    }
    
    func convertUserToViewModel(from user: User) -> UserViewModel {
        
        let viewModel = UserViewModel(model: user)
        
        return viewModel
    }
    
    func setUser(_ user: User) {
        userBox.value = convertUserToViewModel(from: user)
    }
    
    func convertNotificationsToViewModels(from notifications: [Notification]) -> [NotificationViewModel] {
        var viewModels = [NotificationViewModel]()
        for notification in notifications {
            let viewModel = NotificationViewModel(model: notification)
            viewModels.append(viewModel)
        }
        return viewModels
    }
    
    func setNotifications(_ notifications: [Notification]) {
        notificationViewModels.value = convertNotificationsToViewModels(from: notifications)
    }
    
    func createOneNotification(type: String, meetingID: String) {
        self.notification.type = type
        
        self.notification.meetingID = meetingID
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newsUpdated"), object: nil)
        
        create(with: &notification)
    }
    
    // 搜尋 meeting 確定去投票
    func createOwnerNotification(type: String, meetingID: String, ownerID: String) {
        
        fetchOneMeeitngData(meetingID: meetingID)
        
        self.notification.type = type
        
        self.notification.meetingID = self.meeting?.id
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newsUpdated"), object: nil)
        
        create(with: ownerID, notification: &notification)
        
    }
    
    func createInviteNotification(type: String, meetingID: String, participantID: String, name: String, subject: String) {
        
        fetchOneMeeitngData(meetingID: meetingID)
        
        self.notification.type = type
        
        self.notification.meetingID = meetingID
        
        self.notification.subject = subject
        
        self.notification.ownerName = name
        
        self.notification.participantID = participantID
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newsUpdated"), object: nil)
        
        create(with: participantID, notification: &notification)
    }
    
    func createEventNotification(type: String, peopleID: [String], eventID: String, subject: String, image: String) {
        
        self.notification.type = type
        
        self.notification.eventID = eventID
        
        self.notification.subject = subject
        
        self.notification.image = image
        
        create(with: peopleID, notification: &notification)
    }
    
    
    func create(with notification: inout Notification) {
        NotificationManager.shared.createNotification(notification: &notification) { result in
            
            switch result {
            
            case .success:
                
                print("onTapCreate notification, success")
                
            case .failure(let error):
                
                print("create notificationfailure: \(error)")
            }
        }
    }
    
    
    func create(with ownerID: String, notification: inout Notification) {
        NotificationManager.shared.createNotificationforInvite(owenerID: ownerID, notification: &notification) { result in
            
            switch result {
            
            case .success:
                
                print("onTapCreate notification, success")
                INProgressHUD.showSuccess(text: "參加活動成功")
                
            case .failure(let error):
                
                print("create notification.failure: \(error)")
                INProgressHUD.showFailure(text: "請稍後再試")
            }
        }
    }
    
    
    func create(with people: [String], notification: inout Notification) {
        
        for person in people {
            
            NotificationManager.shared.createNotificationforOwner(owenerID: person, notification: &notification) { result in
                
                switch result {
                
                case .success:
                    
                    print("onTapCreate notification, success")
                    
                case .failure(let error):
                    
                    print("create notification.failure: \(error)")
                }
            }
        }
    }
    
    func onTap(withIndex index: Int) {
        
        notificationViewModels.value[index].onTap()
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
    
    func onRefresh() {
        
        self.refreshView?()
    }
    
    func onEmptyTap(_ optionID: String, meetingID: String, selectedOptionID: String) {
        VoteManager.shared.deleteEmptySelectedOption(selectedOptionID: selectedOptionID, optionID: optionID, meetingID: meetingID) { [weak self] result in
            
            switch result {
            
            case .success:
                
                self?.onDead?()
                
            case .failure(let error):
                
                print("deleteData.failure: \(error)")
            }
        }
    }
    
    func onTimeChanged(_ time: Int64) -> String {
        let newTime = Date.timeFormatter.string(from: Date.init(millis: time))
        
        return newTime
    }
    
    func sortVotes(vms: [OptionViewModel]) -> [OptionViewModel] {
        
        let sorted = vms.sorted { $0.selectedOptions!.count > $1.selectedOptions!.count }
        
        return sorted
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
}
