//
//  CloseSuccessVC.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit

class CloseSuccessVC: BaseViewController {

    var viewModel = CreateEventViewModel()

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
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
