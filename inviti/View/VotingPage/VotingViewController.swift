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

    let titles: [String] = ["August 8, Friday", "August 8, Friday", "August 8, Friday", "August 9, Saturday", "August 9, Saturday"]
    let start: [String] = ["11:00 - 13:00", "14:00 - 16:00", "17:00 - 19:00", "11:00 - 13:00", "17:00 - 19:00"]

    let cellSpacingHeight: CGFloat = 5

    var meetingInfo: Meeting!

    var meetingModel = MainVMController()

    let optionViewModels = SelectVMController()

    var meetingDataHandler: ( (Meeting) -> Void)?
    
    @IBOutlet weak var tableview: UITableView!

    @IBOutlet weak var meetingSubject: UILabel!

    @IBOutlet weak var hostNameLabel: UILabel!

    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var popupView: UIView!

    @IBOutlet weak var meetingNotes: UILabel!

    @IBOutlet weak var eventImageBg: UIImageView!

    @IBAction func sendMeeting(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.popupView.isHidden = false
            self.popupView.transform = .identity
            self.meetingDataHandler?(self.meetingInfo)

        }
    }

//    @IBAction func backButton(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }


    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self

        popupView.isHidden = true

        setUpView()

        self.navigationController?.navigationBar.tintColor = UIColor.gray
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear

        optionViewModels.fetchData(meeting: meetingInfo)


        optionViewModels.optionViewModels.bind { [weak self] options in

            self?.optionViewModels.onRefresh()
            self?.tableview.reloadData()

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
        return optionViewModels.optionViewModels.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "votingTableViewCell", for: indexPath) as! VotingTableViewCell

        let index = indexPath.row

        cell.optionViewModels = self.optionViewModels

        cell.setupCell(model: optionViewModels.optionViewModels.value[index], index: index)

        cell.meeting = self.meetingInfo


        return cell
    }

}
