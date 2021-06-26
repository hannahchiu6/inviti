//
//  ShareSuccessVC.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit

class ShareSuccessVC: BaseViewController {
    
    @IBOutlet weak var returnBtnView: UIButton!
    
    var meetingID: String!
    
    var meetingSubject: String?
    
    var viewModel = CreateMeetingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onSubjectAdded = { [weak self] subject in
            
            self?.meetingSubject = subject
        }
    }
    
    @IBAction func returnMain(_ sender: UIButton) {

        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let meetingVC = storyboard.instantiateViewController(identifier: "TabBarVC")
        guard let vc = meetingVC as? TabBarViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func shareLinkBtn(_ sender: Any) {
        let searchID = viewModel.meeting.numberForSearch
        
        if let name = UserDefaults.standard.value(forKey: UserDefaults.Keys.displayName.rawValue),
           let subject = meetingSubject {
            
            let message = "your-friend".localized + " \(name) " + "invite-you".localized + " \(subject) " + "come-and-vote".localized + " 👉🏻 \(searchID)"
            
            let objectsToShare = [message]
            
            let ac = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            ac.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                
                if completed {
                    
                    INProgressHUD.showSuccess(text: "invite-sent")
                    return
                    
                } else {
                    
                    INProgressHUD.showFailure(text: "try-later")
                }
            }
            
            present(ac, animated: true, completion: nil)
            
        }
    }
    
}
