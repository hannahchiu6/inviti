//
//  InvitesViewController.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class InvitesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        self.tabBarController?.tabBar.isHidden = false

        let nib = UINib(nibName: "InvitesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "invitesTableViewCell")

    }

}

extension InvitesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "invitesTableViewCell", for: indexPath) as! InvitesTableViewCell

            return cell
        
    }

}
