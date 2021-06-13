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

    var selectedIndex = [Int]()

    var isVoted: Bool = false

    var onEnableView: (() -> Void)?
    
    @IBOutlet weak var tableview: UITableView!

    @IBOutlet weak var meetingSubject: UILabel!

    @IBOutlet weak var hostNameLabel: UILabel!

    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var hasVotedView: UIView!

    @IBOutlet weak var popupView: UIView!

    @IBOutlet weak var confirmVoteBtnView: UIButton!

    @IBOutlet weak var meetingNotes: UILabel!

    @IBOutlet weak var eventImageBg: UIImageView!

    @IBAction func returnToMain(_ sender: UIButton) {

        navigationController?.popViewController(animated: true)
    }

    @IBAction func sendMeeting(_ sender: UIButton) {
        UIView.animate(withDuration: 1) {

            self.popupView.isHidden = false
            self.popupView.transform = .identity
            self.meetingDataHandler?(self.meetingInfo)
        }

        notificationviewModel.createOneNotification(type: TypeName.vote.rawValue, meetingID: self.meetingInfo.id)

        votingViewModel.updateVotedOption(with: meetingInfo.id, optionIndex: selectedIndex)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self

        popupView.isHidden = true

        hasVotedView.isHidden = true
        
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear

        enableButton(userSelected: false)

        votingViewModel.fetchOptionData(meetingID: meetingInfo.id)

        votingViewModel.fetchUserData(userID: meetingInfo.ownerAppleID)

//        checkSingleVote()

//        checkIfVoted()

        disableBtnIfVoted()

        votingViewModel.optionViewModels.bind { [weak self] options in

            self?.tableview.reloadData()
            self?.checkData()

//            self?.votingViewModel.checkIfVoted(meetingID: self?.meetingInfo.id ?? "")


        }

        votingViewModel.userBox.bind { [weak self] user in

            self?.tableview.reloadData()
            self?.setUpView()

        }
        
        self.tabBarController?.tabBar.isHidden = true

        self.onEnableView = { [weak self] () in

            self?.hasVotedView.isHidden = false

        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "hasVotedSegue" {
            let vc = segue.destination as! HasVotedVC
            vc.delegate = self

            vc.meeting = meetingInfo

            vc.isVoted = isVoted

//            disableBtnIfVoted()

//            votingViewModel.onVoted = { [weak self] () in
//
//                vc.alertMessage.text = "您已經投票過囉！"
//            }
        }
    }

    func checkSingleVote() {

        if meetingInfo.singleMeeting {
            self.tableview.allowsMultipleSelection = false
        }
    }

    func checkIfVoted() {

        if isVoted {
            hasVotedView.isHidden = false
        }
    }

    func checkData() {

        guard let optionIDs = votingViewModel.getOptionsIDs(optionVMs: votingViewModel.optionViewModels.value) as? [String] else { return }

    }

    func disableBtnIfVoted() {

        if meetingInfo.isClosed || isVoted {

            confirmVoteBtnView.isHidden = true
            hasVotedView.isHidden = false

        } else {

            confirmVoteBtnView.isHidden = false
            hasVotedView.isHidden = true

        }
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
        eventImageBg.alpha = 0.3
        hostNameLabel.text = votingViewModel.userBox.value.name
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

        let cell = tableView.dequeueReusableCell(withIdentifier: "votingTableViewCell", for: indexPath) as! VotingTableViewCell

            let index = indexPath.row

            let theOptionVM = votingViewModel.optionViewModels.value[index]

            cell.delegate = self

            cell.votingViewModel = self.votingViewModel

            cell.setupVotingCell(model: theOptionVM, index: index)

            cell.meetingID = self.meetingInfo.id

            cell.optionID = theOptionVM.id

            return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath) as! VotingTableViewCell

        cell.votedYesCell()

        self.enableButton(userSelected: true)

        let index = indexPath.row
        if !selectedIndex.contains(index) {
            selectedIndex.append(indexPath.row)
        }


    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {


            let cell = tableView.cellForRow(at: indexPath) as! VotingTableViewCell

            cell.votedNoCell()

            self.enableButton(userSelected: false)

            if let index = selectedIndex.index(of: indexPath.row) {
                selectedIndex.remove(at: index)

        }
    }
}

extension VotingViewController: VotingTableViewCellDelegate {
    func didVote(_ votedOne: Bool) {
        enableButton(userSelected: votedOne)
    }
}

extension VotingViewController: HasVotedVCDelegate {
    func didTap() {

        navigationController?.popViewController(animated: true)

    }
}
