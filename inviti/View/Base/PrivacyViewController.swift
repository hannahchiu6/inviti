//
//  PrivacyViewController.swift
//  inviti
//
//  Created by Hannah.C on 07.06.21.
//

import UIKit

class PrivacyViewController: UIViewController, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func returnToMain(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
