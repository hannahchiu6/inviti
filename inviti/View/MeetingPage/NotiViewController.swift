//
//  NotiViewController.swift
//  inviti
//
//  Created by Hannah.C on 16.05.21.
//

import UIKit

class NotiViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.shadowView(view)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
}

extension NotiViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotiTableViewCell", for: indexPath) as! NotiTableViewCell
        
        return cell
    }
    
    
}
