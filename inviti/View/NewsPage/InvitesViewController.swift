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

            self?.viewModel.onRefresh()
            self?.tableView.reloadData()
        }

        viewModel.fetchData()

        setupRefresher()
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

            default:

                cell.setupVoteCell(model: model)

            }

            cell.viewModel = viewModel
        }

        return cell
        
    }

}

extension InvitesViewController: RefreshDelegate {
    func refresherDidRefresh(_ refresher: Refresher) {

    }
}
