//
//  ResutlsViewController.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import EasyRefresher

class ResutlsViewController: UIViewController {
    
    var viewModel = VotingViewModel()
    
    var manager = OptionManager()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableviewBG: UIView!
    @IBOutlet weak var background: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.fetchMeetingPackage()
        
        viewModel.meetingViewModels.bind { [weak self] meetings in
            self?.viewModel.onRefresh()
            self?.tableView.reloadData()
        }
        
        //        viewModel.optionViewModels.bind { [weak self] options in
        //            self?.viewModel.onRefresh()
        ////            print("print viewModel.optionViewModels.count")
        ////            print(self?.viewModel.optionViewModels.value.count)
        ////
        //            self?.tableView.reloadData()
        //
        //        }
        
        //        viewModel.voteViewModels.bind { [weak self] votes in
        //             self?.viewModel.onRefresh()
        //       }
        
        //        setupRefresher()
        //        viewModel.fetchVotesData()
        //
        //        print(viewModel.optionViewModels.value)
        
    }
    
    func setupRefresher() {
        self.tableView.refresh.header = RefreshHeader(delegate: self)
        
        tableView.refresh.header.addRefreshClosure { [weak self] in
            self?.viewModel.fetchMeetingData()
            self?.tableView.refresh.header.endRefreshing()
        }
    }
    
}

extension ResutlsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meetingViewModels.value.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsTableViewCell", for: indexPath) as! ResultsTableViewCell
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        
        cell.viewModel.meetingViewModels = viewModel.meetingViewModels
        
        let meetingID = viewModel.meetingViewModels.value[indexPath.row].id
        
        print("Print MeetingID: \(meetingID)")
        //
        //        cell.meetingID = meetingID
        
        //        viewModel.fetchOptionData(meetingID: viewModel.meetingViewModels.value[indexPath.row].id)
        
        //        cell.viewModel.optionViewModels = viewModel.optionViewModels
        
        //        viewModel.fetchOptionData(meetingID: "DKccrRChRF6mm5FahzZX")
        
        //         viewModel.fetchOptionData(meetingID: meetingID)
        cell.collectionView.reloadData()
        
        cell.collectionView.tag = indexPath.row
        
        cell.setupCell(model: viewModel.meetingViewModels.value[indexPath.row])
        
        //        print("\n\nPrint viewModel.optionViewModels.value")
        //        print(viewModel.optionViewModels.value)
        
        return cell
    }
    
}

extension ResutlsViewController: RefreshDelegate {
    func refresherDidRefresh(_ refresher: Refresher) {
        
    }
}

extension ResutlsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: "ResutlsCollectionViewCell"), for: indexPath) as! ResutlsCollectionViewCell
        
        cell.setupCell(model: viewModel.meetingViewModels.value[collectionView.tag].options?[0])
        
        return cell
    }
}
