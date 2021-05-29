//
//  CreateFirstPageVC.swift
//  inviti
//
//  Created by Hannah.C on 16.05.21.
//
//  swiftlint:disable comment_spacing onvenience_type trailing_closure

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


class CreateFirstPageVC: BaseViewController {

    private struct Segue {

        static let success = "SegueSuccess"
    }

    var meetingInfo: Meeting!

//    var options: [Option]? = []

    var isDataEmpty: Bool = true

    var meetingDataHandler: ( (Meeting) -> Void)?

    var isSwitchOn: Bool = false

    let viewModel = CreateMeetingViewModel()

    let mainViewModel = MainVMController()

    var createOptionViewModel = CreateOptionViewModel()

    let selectOptionViewModel = SelectVMController()

    @IBOutlet weak var confirmBtnView: UIButton!

    @IBAction func confirm(_ sender: Any) {

        if isDataEmpty {
//            performSegue(withIdentifier: Segue.success, sender: nil)
            let popOver = storyboard?.instantiateViewController(withIdentifier: "savePopVC") as! PopSaveSuccessVC
            popOver.modalPresentationStyle = .overCurrentContext
            self.present(popOver, animated: true)

//            self.popViewForSave.isHidden = false
//            performSegue(withIdentifier: "successSaveSegue", sender: self)
//            let successVC = storyboard?.instantiateViewController(identifier: "PopSaveVC")
//               guard let success = successVC as? PopSaveSuccessVC else { return }
//
//            navigationController?.pushViewController(success, animated: false)


        } else {

            UIView.animate(withDuration: 5.0, animations: { () -> Void in
                self.popupView.isHidden = false
            })

            meetingDataHandler?(meetingInfo)

        }

        mainViewModel.onMeetingUpdated = {
            self.mainViewModel.updateMeetingData(with: self.viewModel.meeting)
        }

    }

    @IBOutlet weak var popupView: UIView!

    @IBOutlet weak var popViewForSave: UIView!

    @IBOutlet weak var tableview: UITableView!

    @IBAction func nextPage(_ sender: Any) {
        nextPage()

    }


//    override func viewWillAppear(_ animated: Bool) {
//
////        let secondVC = storyboard?.instantiateViewController(identifier: "CMeetingVC")
////           guard let second = secondVC as? CTableViewController else { return }
//        if isDataEmpty {
//        } else {
//        let meetingID = viewModel.meeting.id
//            
////        second.onUpdate = { (meetingID: String) -> Void in
////            self.meetingInfo.id = meetingID
//          selectOptionViewModel.fetchData(meetingID: (meetingID))
////            self.isDataEmpty = false
//        }
////        }
//
//    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "saveSuccessSegue" {
//            let destinationVC = segue.destination as! CTableViewController
//            // Set any variable in ViewController2
//            destinationVC.callbackResult = { data result in
//            // assign passing data etc..
//
////                var meetingID = meetingInfo.id
////                self.tableView.reloadData()
//            }
//        }
//     }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self

        self.popupView.isHidden = true

        tableview.tableHeaderView = nil
        tableview.tableFooterView = nil

        selectOptionViewModel.optionViewModels.bind { [weak self] options in

            self?.selectOptionViewModel.onRefresh()
            self?.tableview.reloadData()

        }


        if meetingInfo != nil {
            confirmBtnView.setTitle("更新活動內容", for: .normal)
            self.navigationController?.isNavigationBarHidden = true

            isDataEmpty = !isDataEmpty
            
            selectOptionViewModel.fetchData(meetingID: meetingInfo.id)

        } else {

            meetingInfo = Meeting(
//                id: UUID().uuidString,
                id: "",
                owner: SimpleUser(id: "", email: "", image: ""),
                createdTime: -1,
                subject: "",
                location: "",
                notes: "",
                image: "",
//                options: [],
                singleMeeting: false,
                hiddenMeeting: false,
                deadlineMeeting: false,
                participants: [],
                numOfParticipants:0,
                deadlineTag: 0)

//            isDataEmpty = !isDataEmpty
//            addParticipants()
        }

    }






//    func addParticipants() {
//
//        guard let currentUserID = UserDefaults.standard.value(forKey: "userID") as? String else { return }
//        guard let currentUserName = UserDefaults.standard.value(forKey: "userName") as? String else { return }
//        guard let currentUserImage = UserDefaults.standard.value(forKey: "userPhoto") as? String else { return }
//
//        self.meetingInfo.participantID.append(participantID)
//        self.meetingInfo.participantName.append(participantName)
//        self.meetingInfo.participantImage.append(participantImage)
//    }


    @objc func enableConfirmBtn(noti: Notification) {
        confirmBtnView.isEnabled = true
        confirmBtnView.backgroundColor = .blue
        confirmBtnView.isHidden = true
    }

    func nextPage() {

        let secondVC = storyboard?.instantiateViewController(identifier: "CMeetingVC")
           guard let second = secondVC as? CTableViewController else { return }

//        viewModel.onMeetingCreated = {
            self.viewModel.create(with: &self.viewModel.meeting)
//        }

        second.meetingID = self.viewModel.meeting.id

           navigationController?.pushViewController(second, animated: true)
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "saveSuccessSegue" {
//            if let presentVC = segue.destination as? PopSaveSuccessVC {
//                presentVC.delegate = self
//
//            }
//
//        }
//    }


}

extension CreateFirstPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section  {
        case 0:
            return 1

        case 2:
          return 1

        default:
            if isDataEmpty {
                return 1
            } else {
                return selectOptionViewModel.optionViewModels.value.count
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreateFirstTableViewCell", for: indexPath) as! CreateFirstCell

                cell.delegate = self

                cell.subjectTextField.text = meetingInfo.subject
                cell.locationTextField.text = meetingInfo.location

            return cell

        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionalSettingsCell", for: indexPath) as! OptionalSettingsCell

            cell.setCell(model: meetingInfo)

            cell.viewModel = self.viewModel

            cell.addSubtract.value = Double(meetingInfo.deadlineTag ?? 0)

                cell.observation = cell.observe(\.addSubtract.value, options: [.old, .new], changeHandler: { (stepper, change) in
                    if change.newValue! == 0.0 {
                        if change.newValue! > change.oldValue! {
                            cell.addSubtract.value = 1
                        } else {
                            cell.addSubtract.value = -1
                        }
                    }
                    self.meetingInfo.deadlineTag = Int(cell.addSubtract.value)
                })
            return cell

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell", for: indexPath) as! OptionsCell

            cell.deleteXview.tag = indexPath.row

            cell.delegate = self

            cell.optionViewModels = self.selectOptionViewModel

            cell.meetingInfo = self.meetingInfo

            if isDataEmpty {

                cell.setupEmptyDataCell()

            } else {

                cell.setupCell(model: selectOptionViewModel.optionViewModels.value[indexPath.row], index: indexPath.row)

            }

            if isDataEmpty {
                return cell
            } else {

                let cellViewModel = self.selectOptionViewModel.optionViewModels.value[indexPath.row]

                cellViewModel.onDead = { [weak self] () in
                    print("onDead")
                    self?.selectOptionViewModel.fetchData(meetingID: (self?.meetingInfo.id)!)
                }
            }

            return cell
        }
    }

}

extension CreateFirstPageVC: CreateFirstCellDelegate {
    func getSubjectData(_ subject: String) {
        viewModel.onSubjectChanged(text: subject)
    }

    func getLocationData(_ location: String) {
        viewModel.onLocationChanged(text: location)
    }
}


extension CreateFirstPageVC: CTableViewDelegate {
    func optionDidSelect(getData: Bool) {
        if getData {
            isDataEmpty = false
        }
    }


}

extension CreateFirstPageVC: SecondCellDelegate {

    func goToSecondPage() {
        nextPage()
    }

}
