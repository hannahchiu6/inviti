//
//  VotingViewController.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit
import Kingfisher
import FirebaseFirestore
import FirebaseFirestoreSwift

class VotingViewController: BaseViewController {

    let cellSpacingHeight: CGFloat = 5

    var meetingInfo: Meeting!

    let optionViewModels = SelectOptionViewModel()

    let votingViewModel = VotingViewModel()

    var notificationviewModel = UpdateNotificationVM()

    var meetingDataHandler: ( (Meeting) -> Void)?
    
    @IBOutlet weak var tableview: UITableView!

    @IBOutlet weak var meetingSubject: UILabel!

    @IBOutlet weak var hostNameLabel: UILabel!

    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var popupView: UIView!

    @IBOutlet weak var confirmVoteBtnView: UIButton!

    @IBOutlet weak var meetingNotes: UILabel!

    @IBOutlet weak var eventImageBg: UIImageView!

    @IBAction func returnToMain(_ sender: UIButton) {

        navigationController?.popViewController(animated: true)
    }

    @IBAction func sendMeeting(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.popupView.isHidden = false
            self.popupView.transform = .identity
            self.meetingDataHandler?(self.meetingInfo)
        }

        notificationviewModel.createOneNotification(type: TypeName.vote.rawValue, meetingID: self.meetingInfo.id)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self

        popupView.isHidden = true

        setUpView()

        self.navigationController?.navigationBar.tintColor = UIColor.gray
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear

        enableButton(userSelected: false)

        votingViewModel.fetchVotedData(meetingID: meetingInfo.id)

        votingViewModel.optionViewModels.bind { [weak self] options in

            self?.votingViewModel.onRefresh()
            self?.tableview.reloadData()

        }

        self.tabBarController?.tabBar.isHidden = true
    }

    func enableButton(userSelected: Bool) {

        if userSelected {

            confirmVoteBtnView.isEnabled = true
            confirmVoteBtnView.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00)

        } else {

            confirmVoteBtnView.isEnabled = false
            confirmVoteBtnView.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)

        }

    }

    func setUpView() {
        guard let url = meetingInfo.image else { return }
            let imageUrl = URL(string: String(url))
        eventImageBg.kf.setImage(with: imageUrl)
        meetingSubject.text = meetingInfo.subject
        locationLabel.text = meetingInfo.location
        meetingNotes.text = meetingInfo.notes
        eventImageBg.alpha = 0.5

        popupView.shadowView(popupView)
    }

    override func viewWillAppear(_ animated: Bool) {
       self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       self.navigationController?.navigationBar.shadowImage = UIImage()
       self.navigationController?.navigationBar.isTranslucent = true
       }

   override func viewWillDisappear(_ animated: Bool) {
       self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       self.navigationController?.navigationBar.shadowImage = UIImage()
       self.navigationController?.navigationBar.isTranslucent = false
   }
}

extension VotingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return votingViewModel.optionViewModels.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let index = indexPath.row

        let theOptionVM = votingViewModel.optionViewModels.value[index]

        let cell = tableView.dequeueReusableCell(withIdentifier: "votingTableViewCell", for: indexPath) as! VotingTableViewCell

        cell.delegate = self

        cell.votingViewModel = self.votingViewModel

        cell.setupVotingCell(model: theOptionVM, index: index)

        cell.meetingID = self.meetingInfo.id

        cell.optionID = theOptionVM.id

        return cell

    }
}

extension VotingViewController: VotingTableViewCellDelegate {
    func didVote(_ votedOne: Bool) {
        enableButton(userSelected: votedOne)
    }


}
