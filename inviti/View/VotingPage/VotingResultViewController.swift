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

    var hasVoted: Bool = false

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

    @IBOutlet weak var bottomView: UIView!
    
    @IBAction func returnToMain(_ sender: Any) {

        navigationController?.popViewController(animated: true)
    }

    @IBAction func sendMeeting(_ sender: Any) {

        if hasVoted {
            UIView.animate(withDuration: 1) {
                self.popupView.isHidden = false
                self.popupView.transform = .identity

                self.eventViewModel.create()

                self.votingViewModel.updateCloseStatus(with: self.meetingInfo.id)
            }
        } else {

            let controller = UIAlertController(title: "您的活動尚未有人投票", message: "確定要結束投票並自訂結果嗎？", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "我確定", style: .default) {(_ ) in

                self.popupView.isHidden = false

                self.popupView.transform = .identity

                self.eventViewModel.create()

                self.votingViewModel.updateCloseStatus(with: self.meetingInfo.id)

            }

            controller.addAction(okAction)

            let closeAction = UIAlertAction(title: "再等等", style: .cancel) { (_) in

                controller.dismiss(animated: true, completion: nil)
            }

            controller.addAction(closeAction)

            present(controller, animated: true, completion: nil)
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addToCalendarSegue" {
            let controller = segue.destination as! CloseSuccessVC

            controller.participants = meetingInfo.participants ?? []

            controller.viewModel = eventViewModel

            controller.eventSubject = meetingInfo.subject

            controller.notificationVM = notificationVM

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self

        self.navigationController?.navigationBar.tintColor = UIColor.gray
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear

        votingViewModel.fetchOneMeeitngData(meetingID: meetingInfo.id)

        votingViewModel.fetchOptionData(meetingID: meetingInfo.id)

        votingViewModel.fetchUserForHost(userID: meetingInfo.ownerAppleID)


        votingViewModel.optionViewModels.bind { [weak self] options in
            self?.votingViewModel.onRefresh()

        }

        votingViewModel.meetingViewModels.bind { [weak self] meetings in
            self?.checkVoted()

        }

        votingViewModel.userBox.bind { [weak self] user in

            self?.votingViewModel.onRefresh()
            self?.hostNameLabel.text = self?.votingViewModel.userBox.value.name ?? "inviti User"

        }

        votingViewModel.refreshView = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableview.reloadData()

            }
        }

        self.tabBarController?.tabBar.isHidden = true

        enableButton()

        setUpView()

        checkVoted()
    }

    func checkVoted() {

        if votingViewModel.isVoted {

            hasVoted = false

        } else {

            hasVoted = true
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

        if meetingInfo.isClosed {

            self.confirmBtnView.isHidden = true
            self.bottomView.isHidden = true

        } else {

            if isSelected {

               self.confirmBtnView.isEnabled = true
               self.confirmBtnView.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00)

           } else {

               self.confirmBtnView.isEnabled = false
               self.confirmBtnView.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)

           }
        }
    }
}

extension VotingResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if meetingInfo.isClosed {

            return 1

        } else {

            return votingViewModel.optionViewModels.value.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let index = indexPath.row

//        let filterOptions = votingViewModel.optionViewModels.value[index]

//        let voteForYesArray = filterOptions?.filter({ $0 != "" })

        if meetingInfo.isClosed {
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultClosedCell", for: indexPath) as! ResultClosedCell

            guard let option = meetingInfo.finalOption else { return cell }
                cell.setupCell(option: option)

            return cell

        } else {

                let cell = tableView.dequeueReusableCell(withIdentifier: "resultTableViewCell", for: indexPath) as! ResultTableViewCell

                cell.votingViewModel = self.votingViewModel

                cell.meetingID = self.meetingInfo.id

            if let filterOptions = votingViewModel.optionViewModels.value[index] as? OptionViewModel {

                cell.setupYesCell(model: filterOptions, index: index)

            } else {

                if let filterOptions = votingViewModel.optionViewModels.value[index] as? OptionViewModel {

                    cell.setupNoCell(model: filterOptions, index: index)
                }
            }

            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let option = votingViewModel.optionViewModels.value[indexPath.row].option as? Option else { return }

        let selectedOption = FinalOption(
            startTime: option.startTime,
            endTime: option.endTime,
            optionTime: option.optionTime)

        guard let optionTime = option.optionTime else { return }

            eventViewModel.onTimeChanged(option.startTime, endTime: option.endTime, option: optionTime)

            eventViewModel.onInfoChanged(meeting: meetingInfo)

            votingViewModel.onMeetingOptionChanged(selectedOption)

            isSelected = true

            enableButton()

    }
}
