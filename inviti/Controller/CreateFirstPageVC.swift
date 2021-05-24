//
//  CreateFirstPageVC.swift
//  inviti
//
//  Created by Hannah.C on 16.05.21.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


class CreateFirstPageVC: BaseViewController {

    private struct Segue {

        static let success = "SegueSuccess"
    }

    var meetingInfo: Meeting!

    var isDataEmpty: Bool = true

    var meetingDataHandler: ( (Meeting) -> Void)?

    var isSwitchOn: Bool = false

    let viewModel = CreateViewModel()
    

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

        viewModel.create(with: &viewModel.meeting)
    }

    @IBOutlet weak var popupView: UIView!

    @IBOutlet weak var popViewForSave: UIView!

    @IBOutlet weak var tableview: UITableView!

    @IBAction func nextPage(_ sender: Any) {
        nextPage()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
//        confirmBtnView.isEnabled = false
//        self.popViewForSave.isHidden = true
        self.popupView.isHidden = true

        tableview.tableHeaderView = nil
        tableview.tableFooterView = nil

//        NotificationCenter.default.addObserver(self,
//                                                selector: #selector(enableConfirmBtn), name:
//                                                Notification.Name("reloadCollection"),
//                                                object: nil)

        if meetingInfo != nil {
            confirmBtnView.setTitle("更新活動內容", for: .normal)
            self.navigationController?.isNavigationBarHidden = true

            isDataEmpty = !isDataEmpty

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
//        let secondVC = storyboard?.instantiateViewController(identifier: "SecondVC")
//           guard let second = secondVC as? Calend else { return }
        let secondVC = storyboard?.instantiateViewController(identifier: "TestMeetingVC")
           guard let second = secondVC as? CTableViewController else { return }

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

//    func checkUpdateStatus() {
//
//        if isSwitchOn {
//            confirmBtnView.isEnabled = false
//            confirmBtnView.setTitleColor(UIColor.B5, for: .normal)
//        } else {
//            confirmBtnView.isEnabled = false
//            confirmBtnView.setTitleColor(UIColor.B5, for: .normal)
//        }
//        confirmBtnView.setTitleColor(UIColor.lightGray, for: .disabled)
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
                return 3
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

//            cell.singleView.addTarget(self, action: #selector(updateSwitcher), for: .valueChanged)
//            cell.hiddenView.addTarget(self, action: #selector(updateSwitcher), for: .valueChanged)
//            cell.deadlineView.addTarget(self, action: #selector(updateSwitcher), for: .valueChanged)
            cell.setCell(model: meetingInfo)

            cell.viewModel = self.viewModel

            cell.addSubtract.value = Double(meetingInfo.deadlineTag)

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

            cell.delegate = self


            if isDataEmpty {

                cell.optionsStackView.isHidden = false

            } else {

                cell.optionsStackView.isHidden = true
                    if indexPath.row == 0 {
                        cell.bottomAlarmIcon.isHidden = false
                    } else {
                        cell.bottomAlarmIcon.isHidden = true
                    }
            }

            return cell
        }
    }

//    @objc func updateSwitcher() {
//        confirmBtnView.isEnabled = false
//        isSwitchOn = !isSwitchOn
//        tableview.reloadData()
//    }
}

extension CreateFirstPageVC: CreateFirstCellDelegate {
    func getSubjectData(_ subject: String) {
        viewModel.onSubjectChanged(text: subject)
    }

    func getLocationData(_ location: String) {
        viewModel.onLocationChanged(text: location)
    }
}

//extension CreateFirstPageVC: PopSaveSuccessDelegate {
//
//    func didTap() {
//        popViewForSave.isHidden = true
//
////        if let backVC = UIStoryboard.meeting.instantiateInitialViewController() {
////            backVC.modalPresentationStyle = .overCurrentContext
////
////            present(backVC, animated: false, completion: nil)
////
////        }
//        self.pop(numberOfTimes: 1)
////        self.navigationController?.popViewController(animated: true)
//    }
//}

extension CreateFirstPageVC: SecondCellDelegate{

    func goToSecondPage() {
        nextPage()
    }

}

//extension CreateFirstPageVC: ThirdCellDelegate {
//    func getSingleData(_ boolean: Bool) {
//        viewModel.meetingSingleChanged(boolean)
//    }
//
//    func getHiddenData(_ boolean: Bool) {
//
//        viewModel.meetingHiddenChanged(boolean)
//    }
//
//    func getDeadlineData(_ boolean: Bool) {
//
//        viewModel.meetingDeadlineChanged(boolean)
//    }
//
//    func getDeadlineDayData(_ day: Int) {
//
//        viewModel.onDeadlineTagChanged(day)
//
//    }
//
//    func getNotesData(_ notes: String) {
//
//        viewModel.onNotesChanged(text: notes)
//    }
//}
