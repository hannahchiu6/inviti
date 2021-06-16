//
//  CloseSuccessVC.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit

class CloseSuccessVC: BaseViewController {
    
    var viewModel = CreateEventViewModel()
    
    var notificationVM = UpdateNotificationVM()
    
    var eventID: String? = ""
    
    var eventSubject: String? = ""
    
    var participants: [String] = []
    
    @IBOutlet weak var returnBtnView: UIButton!
    
    @IBAction func returnCalendar(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Calendar", bundle: nil)
        let calendarVC = storyboard.instantiateViewController(identifier: "TabCalendarVC")
        
        guard let vc = calendarVC as? TabCalendarViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func shareLinkBtn(_ sender: Any) {
        
        viewModel.createForParticipants(peopleID: participants)
        
        notificationVM.onImageChanged(notificationVM.userViewModel.user.image ?? "")
        
        guard let ownerImage = UserDefaults.standard.value(forKey: UserDefaults.Keys.image.rawValue) as? String else { return }
        
        let eventID = viewModel.event.id
        
        if let subject = eventSubject {
            
            notificationVM.createEventNotification(type: TypeName.calendar.rawValue, peopleID: participants, eventID: eventID, subject: subject, image: ownerImage)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
