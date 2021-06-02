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

    var optionID: String = ""

    var meetingID: String?

    var isDataEmpty: Bool = false

    var meetingDataHandler: ((Meeting) -> Void)?

    var isSwitchOn: Bool = false

    var createMeetingViewModel = CreateMeetingViewModel()

//    var meetingViewModel = createMeetingViewModel.meetingViewModel

//    var mainViewModel = MainVMController()

//    var createOptionViewModel = CreateOptionViewModel()

    var selectOptionViewModel = SelectOptionViewModel()

    @IBOutlet weak var confirmBtnView: UIButton!

    @IBAction func deleteMeeting(_ sender: Any) {

        print("deleteMeeting clicked!")
//        createMeetingViewModel.onOneTap(meetingID: meetingID!)


        let storyboard: UIStoryboard = UIStoryboard(name: "Meeting", bundle: nil)
        let meetingVC = storyboard.instantiateViewController(identifier: "MeetingVC")
        guard let vc = meetingVC as? MeetingViewController else { return }


        self.navigationController?.show(vc, sender: true)

    }

    @IBAction func confirm(_ sender: Any) {

        if meetingInfo == nil {
        UIView.animate(withDuration: 5.0, animations: { () -> Void in
            self.popView.isHidden = false
            self.createMeetingViewModel.update(with: self.createMeetingViewModel.meeting)

        })} else {

        performSegue(withIdentifier: "showSuccessSegue", sender: self)
            createMeetingViewModel.update(with: meetingInfo)
        }


    }


    @IBOutlet weak var popView: UIView!

    @IBOutlet weak var tableview: UITableView!

    @IBAction func nextPage(_ sender: Any) {
        nextPage()
    }

    override func viewWillAppear(_ animated: Bool) {

        createMeetingViewModel.fetchOneMeeitngData(meetingID: meetingID ?? "")

        selectOptionViewModel.fetchData(meetingID: meetingID ?? "" )

        if selectOptionViewModel.optionViewModels.value.isEmpty {

            print("there's no options have been selected yet.")

        } else {

            self.isDataEmpty = false

        }

        tableview.reloadData()

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self

        self.popView.isHidden = true

        tableview.tableHeaderView = nil
        tableview.tableFooterView = nil

        selectOptionViewModel.optionViewModels.bind { [weak self] options in
            self?.selectOptionViewModel.onRefresh()
            self?.tableview.reloadData()
            self?.enableButton()
        }

        createMeetingViewModel.meetingViewModels.bind { [weak self] meetings in
            self?.createMeetingViewModel.onRefresh()
            self?.tableview.reloadData()
        }

        isDataGet()

        confirmBtnView.isEnabled = false

        NotificationCenter.default.addObserver(self, selector: #selector(textChanged), name: UITextField.textDidChangeNotification, object: nil)
    }

    // swiftLint disable: operator_usage_whitespace empty_string

    @objc func textChanged() {

//        let cellOne = createMeetingViewModel.meeting.subject
//        let cellTwo = createMeetingViewModel.meeting.location
//
//        if cellOne != "" && cellTwo != "" && selectOptionViewModel.optionViewModels.value.isEmpty != true {
//
//            self.confirmBtnView.isEnabled = true
//            self.confirmBtnView.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00)
//
//        } else {
//            self.confirmBtnView.isEnabled = false
//            self.confirmBtnView.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
//
//        }
    }

    func enableButton() {

       let cellOne = createMeetingViewModel.meeting.subject
       let cellTwo = createMeetingViewModel.meeting.location

       if cellOne != "" && cellTwo != "" && selectOptionViewModel.optionViewModels.value.isEmpty != true {

           self.confirmBtnView.isEnabled = true
           self.confirmBtnView.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00)

       } else {
           self.confirmBtnView.isEnabled = false
           self.confirmBtnView.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)

       }
    }



    func isDataGet() {

        let optionData = selectOptionViewModel.optionViewModels.value

        if optionData.isEmpty {

            isDataEmpty = true

        } else {

            selectOptionViewModel.fetchData(meetingID: meetingInfo.id)
        }

        if meetingInfo != nil {

            confirmBtnView.setTitle("更新活動內容", for: .normal)
            self.navigationController?.isNavigationBarHidden = true

            isDataEmpty = !isDataEmpty

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

    func nextPage() {

        let secondVC = storyboard?.instantiateViewController(identifier: "CMeetingVC")
           guard let second = secondVC as? CTableViewController else { return }

        createMeetingViewModel.update(with: createMeetingViewModel.meeting)

        second.selectedOptionViewModel = selectOptionViewModel

        second.meetingID = meetingID ?? ""

        navigationController?.pushViewController(second, animated: true)
    }
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

            if createMeetingViewModel.meetingViewModels.value.isEmpty {

                cell.setCell(model: createMeetingViewModel.meetingViewModel)

                cell.viewModel = self.createMeetingViewModel.meetingViewModel

            } else {

                let data = createMeetingViewModel.meetingViewModels.value[indexPath.row]

                cell.setCell(model: data)

                cell.viewModel = data

            }

            return cell

        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionalSettingsCell", for: indexPath) as! OptionalSettingsCell

            if createMeetingViewModel.meetingViewModels.value.isEmpty {

                cell.setCell(model: createMeetingViewModel.meetingViewModel)

                cell.viewModel = self.createMeetingViewModel

                cell.addSubtract.value = Double(createMeetingViewModel.meetingViewModel.meeting.deadlineTag ?? 0)

                    cell.observation = cell.observe(\.addSubtract.value, options: [.old, .new], changeHandler: { (stepper, change) in
                        if change.newValue! == 0.0 {
                            if change.newValue! > change.oldValue! {
                                cell.addSubtract.value = 1
                            } else {
                                cell.addSubtract.value = -1
                            }
                        }
                        self.createMeetingViewModel.meetingViewModel.meeting.deadlineTag = Int(cell.addSubtract.value)
                    })
                return cell
                
            } else {

                let data = createMeetingViewModel.meetingViewModels.value[indexPath.row]

                cell.setCell(model: data)

                cell.viewModel = createMeetingViewModel

                cell.addSubtract.value = Double(data.meeting.deadlineTag ?? 0)

                    cell.observation = cell.observe(\.addSubtract.value, options: [.old, .new], changeHandler: { (stepper, change) in
                        if change.newValue! == 0.0 {
                            if change.newValue! > change.oldValue! {
                                cell.addSubtract.value = 1
                            } else {
                                cell.addSubtract.value = -1
                            }
                        }
                        self.createMeetingViewModel.meetingViewModels.value[indexPath.row].meeting.deadlineTag = Int(cell.addSubtract.value)
                    })
                return cell

            }

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell", for: indexPath) as! OptionsCell

            cell.deleteXview.tag = indexPath.row

            cell.delegate = self

            cell.selectedOptionViewModel = self.selectOptionViewModel

            cell.meetingInfo = self.meetingInfo

            if isDataEmpty {

                cell.setupEmptyDataCell()

            } else {

                cell.setupCell(model: selectOptionViewModel.optionViewModels.value[indexPath.row], index: indexPath.row)

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
        createMeetingViewModel.onSubjectChanged(text: subject)
    }

    func getLocationData(_ location: String) {
        createMeetingViewModel.onLocationChanged(text: location)
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

    func deleteTap(_ index: Int, vms: SelectOptionViewModel) {
        
        optionID = selectOptionViewModel.getOptionID(in: selectOptionViewModel.optionViewModels.value, index: index)

        selectOptionViewModel.onEmptyTap(optionID, meetingID: meetingID ?? "")

        selectOptionViewModel.fetchData(meetingID: meetingID ?? "")

        if selectOptionViewModel.optionViewModels.value.isEmpty {
            isDataEmpty = true
        }

    }

    func goToSecondPage() {
        nextPage()
    }
}
