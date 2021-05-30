//  FurtureTableViewController.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import EasyRefresher

class FurtureTableViewController: UITableViewController {

    let viewModel = MainVMController()

    var selectedIndex: Int?

//    var meetingData: Meeting?

//    var refreshControl: UIRefreshControl!


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.do_registerCellWithNib(
            identifier: String(describing: MeetingTableViewCell.self),bundle: nil)

        viewModel.refreshView = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.meetingViewModels.bind { [weak self] meetings in
            self?.viewModel.onRefresh()
        }

        viewModel.scrollToTop = { [weak self] () in

            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }

        viewModel.fetchNewData()

        setupRefresher()

    }

    func setupRefresher() {
        self.tableView.refresh.header = RefreshHeader(delegate: self)

        tableView.refresh.header.addRefreshClosure { [weak self] in
            self?.viewModel.fetchNewData()
            self?.tableView.refresh.header.endRefreshing()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.meetingViewModels.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MeetingTableViewCell.self), for: indexPath) as! MeetingTableViewCell

        cell.delegate = self

        cell.index = indexPath.row

        cell.completionHandler = { index in
            self.selectedIndex = index
        }

//        cell.firstParticipantView.loadImage("\(String(describing: meetingVM?.participants[indexPath.section].image))")
//        cell.secondParticipantView.loadImage("\(String(describing: meetingVM?.userImage))")
//        cell.thirdParticipantView.loadImage("\(String(describing: meetingVM?.userImage))")
       

        guard let meetingViewCell = cell as? MeetingTableViewCell else {
            return cell
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        let cellViewModel = self.viewModel.meetingViewModels.value[indexPath.row]

        cellViewModel.onDead = { [weak self] () in
            print("onDead")
            self?.viewModel.fetchNewData()
        }

        meetingViewCell.setup(viewModel: cellViewModel)

//        let tap = UITapGestureRecognizer(target: self, action: #selector(toCreatePage(_:)))
//        cell.background.addGestureRecognizer(tap)

        return meetingViewCell

    }

//    @objc func toCreatePage(_ sender: UIGestureRecognizer) {
//
//        guard let viewController = UIStoryboard(name: "Create", bundle: nil).instantiateViewController(identifier: "CreateFirstPageVC") as? CreateFirstPageVC else { return }
//
//        guard let cell = sender.view?.superview?.superview as? CreateFirstCell,
//              let indexPath = tableView.indexPath(for: cell)
//
//        else {
//            return
//        }
//
//        viewController.meetingInfo = meetingData
//
//        show(viewController, sender: nil)
//    }

//    func addRefreshControl() {
//
//        refreshControl = UIRefreshControl()
//        tableView.addSubview(refreshControl)
//        refreshControl.addTarget(self, action: #selector(getMeetingData), for: .valueChanged)
//
//    }
//
//    @objc func getMeetingData() {
//
//        UploadManager.shared.simplePetInfo.removeAll()
//        DownloadManager.shared.petData.removeAll()
//
//        DownloadManager.shared.downloadPetData { result in
//
//            switch result {
//
//            case .success(let downloadPetData):
//                self.petData = downloadPetData
//                self.alertView.isHidden = self.petData.count != 0
//            case . failure(let error):
//                print(error)
//            }
//        }
//    }
}

extension FurtureTableViewController: MeetingTableCellDelegate {
    func deleteBtnPressed(_ sender: MeetingTableViewCell) {

        guard let indexPath = self.tableView.indexPath(for: sender) else { return }
        UIView.animate(withDuration: 3, delay: 1, options: .curveEaseOut, animations: {
            sender.alpha = 1
        }, completion: {_ in
            self.viewModel.onTap(withIndex: indexPath.row)
        })
    }

    func editButtonPressed(_ sender: MeetingTableViewCell) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Create", bundle: nil)
        let editVC = storyboard.instantiateViewController(identifier: "CreateFirstPageVC")
           guard let edit = editVC as? CreateFirstPageVC else { return }

        guard self.tableView.indexPath(for: sender) != nil else { return }

        edit.meetingInfo = sender.meeting

        edit.meetingID = sender.meeting?.id
//        edit.createMeetingViewModel.meetingViewModels.value[0] = viewModel.meetingViewModels.value[0]

        navigationController?.pushViewController(edit, animated: true)
    }

    func goButtonPressed(_ sender: MeetingTableViewCell) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Voting", bundle: nil)
        let votingVC = storyboard.instantiateViewController(identifier: "VotingVC")
           guard let voting = votingVC as? VotingViewController else { return }

        guard self.tableView.indexPath(for: sender) != nil else { return }

        voting.meetingInfo = sender.meeting

        navigationController?.pushViewController(voting, animated: true)

    }
}

extension FurtureTableViewController: RefreshDelegate {
    func refresherDidRefresh(_ refresher: Refresher) {
        print("refresherDidRefresh")
    }
}
