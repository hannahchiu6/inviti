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

class VotingViewController: UIViewController {

    let cellSpacingHeight: CGFloat = 5

    var meetingInfo: Meeting!

    let optionViewModels = SelectOptionViewModel()

    let votingViewModel = VotingViewModel()

    var meetingDataHandler: ( (Meeting) -> Void)?
    
    @IBOutlet weak var tableview: UITableView!

    @IBOutlet weak var meetingSubject: UILabel!

    @IBOutlet weak var hostNameLabel: UILabel!

    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var popupView: UIView!

    @IBOutlet weak var meetingNotes: UILabel!

    @IBOutlet weak var eventImageBg: UIImageView!

    @IBAction func returnToMain(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func sendMeeting(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.popupView.isHidden = false
            self.popupView.transform = .identity
            self.meetingDataHandler?(self.meetingInfo)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self

        popupView.isHidden = true

        setUpView()

        self.navigationController?.navigationBar.tintColor = UIColor.gray
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear

//        optionViewModels.fetchData(meetingID: meetingInfo.id)


//        optionViewModels.optionViewModels.bind { [weak self] options in
//
//            self?.optionViewModels.onRefresh()
//            self?.tableview.reloadData()
//        }
        votingViewModel.fetchVoteForYes(meetingID: meetingInfo.id)

        votingViewModel.optionViewModels.bind { [weak self] options in

            self?.votingViewModel.onRefresh()
            self?.tableview.reloadData()
        }




        self.tabBarController?.tabBar.isHidden = true
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

        let cell = tableView.dequeueReusableCell(withIdentifier: "votingTableViewCell", for: indexPath) as! VotingTableViewCell

        let filterOptions = votingViewModel.optionViewModels.value[index].selectedOptions

        let voteForYesArray = filterOptions?.filter({ $0.isSelected == true })

        switch filterOptions?.count {

        case 0:

            let cell = tableView.dequeueReusableCell(withIdentifier: "votingTableViewCell", for: indexPath) as! VotingTableViewCell

            cell.votingViewModel = self.votingViewModel

            cell.setupVotingCell(model: votingViewModel.optionViewModels.value[index], index: index)

            cell.meetingID = self.meetingInfo.id

            cell.optionID = votingViewModel.optionViewModels.value[index].id

//            cell.optionViewModels = self.optionViewModels
//
//            cell.setupVotingCell(model: optionViewModels.optionViewModels.value[index], index: index)
//
//            cell.meetingID = self.meetingInfo.id
//
//            cell.votingViewModel = self.votingViewModel
//
//            cell.optionID = optionViewModels.optionViewModels.value[index].id

            return cell

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultTableViewCell", for: indexPath) as! ResultTableViewCell


            if votingViewModel.optionViewModels.value[index].selectedOptions?.count ?? 0 > 0 {

            cell.votingViewModel = self.votingViewModel

            cell.meetingID = self.meetingInfo.id

            cell.setupYesCell(model: votingViewModel.optionViewModels.value[index], index: index)

            return cell

            }

        }

        return cell
    }
}
