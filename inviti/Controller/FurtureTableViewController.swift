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
//            self?.tableView.reloadData()
            self?.viewModel.onRefresh()
        }

        viewModel.scrollToTop = { [weak self] () in

            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }

        viewModel.fetchNewData()

        setupRefresher()

    }

    let viewModel = MainViewModel()

//    var meetingVM: MeetingViewModel?

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

//        cell.firstParticipantView.loadImage("\(String(describing: meetingVM?.participants[indexPath.section].image))")
//        cell.secondParticipantView.loadImage("\(String(describing: meetingVM?.userImage))")
//        cell.thirdParticipantView.loadImage("\(String(describing: meetingVM?.userImage))")
       

        guard let meetingViewCell = cell as? MeetingTableViewCell else {
            return cell
        }

        let cellViewModel = self.viewModel.meetingViewModels.value[indexPath.row]
        cellViewModel.onDead = { [weak self] () in
            print("onDead")
            self?.viewModel.fetchNewData()
        }
        meetingViewCell.setup(viewModel: cellViewModel)

        return meetingViewCell
    }
}

extension FurtureTableViewController: MeetingTableCellDelegate {
    func deleteBtnPressed() {
       
    }

    func editButtonPressed() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Create", bundle: nil)
        let editVC = storyboard.instantiateViewController(identifier: "CreateFirstPageVC")
           guard let edit = editVC as? CreateFirstPageVC else { return }
        navigationController?.pushViewController(edit, animated: true)
    }

    func goButtonPressed() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Voting", bundle: nil)
        let votingVC = storyboard.instantiateViewController(identifier: "VotingVC")
           guard let voting = votingVC as? VotingViewController else { return }
        navigationController?.pushViewController(voting, animated: true)

    }
}

extension FurtureTableViewController: RefreshDelegate {
    func refresherDidRefresh(_ refresher: Refresher) {
        print("refresherDidRefresh")
    }
}
