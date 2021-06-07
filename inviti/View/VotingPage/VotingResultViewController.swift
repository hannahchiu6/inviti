//
//  VotingResultViewController.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit
import Kingfisher
import FirebaseFirestore
import FirebaseFirestoreSwift

class VotingResultViewController: UIViewController {

    let cellSpacingHeight: CGFloat = 5

    var meetingInfo: Meeting!

    var isSelected: Bool = false

    let eventViewModel = CreateEventViewModel()

    let votingViewModel = VotingViewModel()

    var notificationVM = UpdateNotificationVM()

    let ownerAppleID: String = UserDefaults.standard.value(forKey: UserDefaults.Keys.uid.rawValue) as! String

    var meetingDataHandler: ( (Meeting) -> Void)?
    
    @IBOutlet weak var tableview: UITableView!

    @IBOutlet weak var meetingSubject: UILabel!

    @IBOutlet weak var hostNameLabel: UILabel!

    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var popupView: UIView!

    @IBOutlet weak var meetingNotes: UILabel!

    @IBOutlet weak var eventImageBg: UIImageView!

    @IBOutlet weak var confirmBtnView: UIButton!

    @IBAction func returnToMain(_ sender: Any) {

        navigationController?.popViewController(animated: true)
    }

    @IBAction func sendMeeting(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.popupView.isHidden = false
            self.popupView.transform = .identity

            self.eventViewModel.create()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addToCalendarSegue" {
            let controller = segue.destination as! CloseSuccessVC

            notificationVM.fetchUserData(userID: meetingInfo.ownerAppleID)

            controller.participants = meetingInfo.participants ?? []

            controller.viewModel = eventViewModel

            controller.notificationVM = notificationVM

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self

        setUpView()

        self.navigationController?.navigationBar.tintColor = UIColor.gray
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear

        votingViewModel.fetchVotedData(meetingID: meetingInfo.id)

        votingViewModel.optionViewModels.bind { [weak self] options in

            self?.votingViewModel.onRefresh()
            self?.tableview.reloadData()

        }

        self.tabBarController?.tabBar.isHidden = true

        enableButton()
    }

    func setUpView() {

        guard let url = meetingInfo.image else { return }
            let imageUrl = URL(string: String(url))
        eventImageBg.kf.setImage(with: imageUrl)
        meetingSubject.text = meetingInfo.subject
        locationLabel.text = meetingInfo.location
        meetingNotes.text = meetingInfo.notes
        eventImageBg.alpha = 0.5

        popupView.isHidden = true

        confirmBtnView.isEnabled = false

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

    func enableButton() {

        if isSelected {

           self.confirmBtnView.isEnabled = true
           self.confirmBtnView.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00)

       } else {
           self.confirmBtnView.isEnabled = false
           self.confirmBtnView.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)

       }
    }
}

extension VotingResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return votingViewModel.optionViewModels.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let index = indexPath.row

        let filterOptions = votingViewModel.optionViewModels.value[index].selectedOptions

        let voteForYesArray = filterOptions?.filter({ $0.isSelected == true })

            let cell = tableView.dequeueReusableCell(withIdentifier: "resultTableViewCell", for: indexPath) as! ResultTableViewCell

            cell.votingViewModel = self.votingViewModel

            cell.meetingID = self.meetingInfo.id

            cell.setupYesCell(model: votingViewModel.optionViewModels.value[index], index: index)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedOption = votingViewModel.optionViewModels.value[indexPath.row]

        guard let info = meetingInfo else { return }

        self.eventViewModel.onInfoChanged(text: info.subject!, location: info.location!, date: Int(selectedOption.optionTime.dateInt()) ?? 0)

        eventViewModel.onTimeChanged(selectedOption.startTime, endTime: selectedOption.endTime)

//        eventViewModel.onOwnerChanged(text: ownerAppleID)

        isSelected = true

        enableButton()
    }
}
