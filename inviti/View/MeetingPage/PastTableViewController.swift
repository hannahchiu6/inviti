//
//  PastTableViewController.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import EasyRefresher

class PastTableViewController: UITableViewController {
    
    let viewModel = MainViewModel()
    
    var selectedIndex: Int?
    
    var userUID = UserDefaults.standard.value(forKey: UserDefaults.Keys.uid.rawValue) as? String ?? ""
    
    var isVoted: Bool = false
    
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
        }
        
        viewModel.fetchParticipatedData()
        
        setupRefresher()
    }
    
    
    func setupRefresher() {
        self.tableView.refresh.header = RefreshHeader(delegate: self)
        
        tableView.refresh.header.addRefreshClosure { [weak self] in
            self?.viewModel.fetchParticipatedData()
            self?.tableView.refresh.header.endRefreshing()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.meetingViewModels.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MeetingTableViewCell.self), for: indexPath)
        
        guard let meetingCell = cell as? MeetingTableViewCell else { return cell }
        
        meetingCell.index = indexPath.row
        
        meetingCell.mainViewModel = viewModel
        
        meetingCell.setupParticipatedCell()
        
        meetingCell.completionHandler = {index in
            self.selectedIndex = index
        }

        let cellViewModel = self.viewModel.meetingViewModels.value[indexPath.row]
        
        cellViewModel.onDead = { [weak self] () in
            print("onDead")
            self?.viewModel.fetchParticipatedData()
        }
        
        meetingCell.setup(viewModel: cellViewModel)
        
        return meetingCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = self.viewModel.meetingViewModels.value[indexPath.row].meeting
        
        guard  let options = model.options else { return }
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Voting", bundle: nil)
        
        let votingVC = storyboard.instantiateViewController(identifier: "VotingVC")
        
        guard let voting = votingVC as? VotingViewController else { return }

        
        var votedOptions: [String] = []
        
        for i in 0...options.count - 1 {
            
            votedOptions = options[i].selectedOptions?.filter({ $0 == userUID }) ?? []
            
        }
        if !votedOptions.isEmpty {
            
            voting.isVoted = true
            
            voting.onEnableView?()
        }
        
        voting.meetingInfo = model
        
        navigationController?.pushViewController(voting, animated: true)
    }
    
}

extension PastTableViewController: RefreshDelegate {
    func refresherDidRefresh(_ refresher: Refresher) {
        
    }
}
