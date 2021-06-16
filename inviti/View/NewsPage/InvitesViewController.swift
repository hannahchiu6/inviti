//
//  InvitesViewController.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit
import EasyRefresher

class InvitesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel = UpdateNotificationVM()

    var observation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        self.tabBarController?.tabBar.isHidden = false

        let nib = UINib(nibName: "InvitesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "invitesTableViewCell")

        viewModel.notificationViewModels.bind { [weak self] notifications in

            self?.refreshTabBar()
            self?.tableView.reloadData()
        }

        viewModel.fetchData()

        setupRefresher()

    }

    func refreshTabBar() {

        if let items = self.tabBarController?.tabBar.items as NSArray? {

            let tabItem = items.object(at: 1) as! UITabBarItem

            guard let number = viewModel.notificationViewModels.value.count as? Int else { return }

            if number > 0 {
                tabItem.badgeValue = "\(number)"
            } else {
                tabItem.badgeValue = nil
            }
        }
    }

    func setupRefresher() {
        self.tableView.refresh.header = RefreshHeader(delegate: self)

        tableView.refresh.header.addRefreshClosure { [weak self] in
            self?.viewModel.fetchData()
            self?.tableView.refresh.header.endRefreshing()
        }
    }


}

extension InvitesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if viewModel.notificationViewModels.value.isEmpty {

            return 1

        } else {

            return viewModel.notificationViewModels.value.count
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "invitesTableViewCell", for: indexPath) as! InvitesTableViewCell

        cell.deleteBtnView.tag = indexPath.row

        if viewModel.notificationViewModels.value.isEmpty {

            cell.setupEmptyCell()

        } else {

            let index = indexPath.row

            let model = viewModel.notificationViewModels.value[index]

            switch model.type {

            case TypeName.calendar.rawValue:

                cell.setupEventCell(model: model)

            case TypeName.invite.rawValue:

                cell.setupInviteCell(model: model)

                cell.voteBtnView.addTarget(self, action: #selector(goToVote), for: UIControl.Event.touchUpInside)

                cell.voteBtnView.tag = index

            default:

                cell.setupVoteCell(model: model)

            }

            cell.viewModel = viewModel

            guard let inviteViewCell = cell as? InvitesTableViewCell else {
                return cell
            }

            let cellViewModel = self.viewModel.notificationViewModels.value[index]
            
            cellViewModel.onDead = { [weak self] () in

                self?.viewModel.fetchData()
            }

            return inviteViewCell
        }

        return cell
        
    }

    @objc func goToVote(sender: UIButton) {

        let storyboard: UIStoryboard = UIStoryboard(name: "Voting", bundle: nil)
        let votingVC = storyboard.instantiateViewController(identifier: "VotingVC")
           guard let voting = votingVC as? VotingViewController else { return }

        let meetingID = viewModel.notificationViewModels.value[sender.tag].meetingID ?? ""

        viewModel.fetchOneMeeitngData(meetingID: meetingID)

        voting.meetingInfo = viewModel.meeting

        navigationController?.pushViewController(voting, animated: true)

    }

}

extension InvitesViewController: RefreshDelegate {
    func refresherDidRefresh(_ refresher: Refresher) {

    }
}
