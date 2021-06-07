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

    let viewModel = MainViewModel()

    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.do_registerCellWithNib(
            identifier: String(describing: MeetingTableViewCell.self), bundle: nil)

        viewModel.refreshView = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.meetingViewModels.bind { [weak self] meetings in
            self?.viewModel.onRefresh()
//            self?.tableView.reloadData()
        }

//        viewModel.scrollToTop = { [weak self] () in
//
//            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        }

        viewModel.fetchHostedData()

        setupRefresher()
    }

    func setupRefresher() {
        self.tableView.refresh.header = RefreshHeader(delegate: self)

        tableView.refresh.header.addRefreshClosure { [weak self] in
            self?.viewModel.fetchHostedData()
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
        guard let meetingViewCell = cell as? MeetingTableViewCell else {
            return cell
        }

        let cellViewModel = self.viewModel.meetingViewModels.value[indexPath.row]

        cellViewModel.onDead = { [weak self] () in
            print("onDead")
            self?.viewModel.fetchHostedData()
        }

        meetingViewCell.setup(viewModel: cellViewModel)

        return meetingViewCell

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyBoard : UIStoryboard = UIStoryboard(name: "Voting", bundle: nil)
        guard let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResultVC") as? VotingResultViewController else { return }

        nextViewController.meetingInfo = self.viewModel.meetingViewModels.value[indexPath.row].meeting

        navigationController?.pushViewController(nextViewController, animated: true)

    }
}

extension FurtureTableViewController: MeetingTableCellDelegate {
    func deleteBtnPressed(_ sender: MeetingTableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: sender) else { return }
        viewModel.onTap(withIndex: indexPath.row)
    }

    func editButtonPressed(_ sender: MeetingTableViewCell) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Create", bundle: nil)
        let editVC = storyboard.instantiateViewController(identifier: "CreateFirstPageVC")
           guard let edit = editVC as? CreateFirstViewController else { return }

        guard self.tableView.indexPath(for: sender) != nil else { return }

        edit.meetingInfo = sender.meeting

        edit.meetingID = sender.meeting?.id

        edit.createMeetingViewModel.meetingViewModel = sender.viewModel!

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

    }
}
