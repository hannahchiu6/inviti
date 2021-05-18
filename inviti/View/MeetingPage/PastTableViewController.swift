//
//  PastTableViewController.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit

class PastTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.do_registerCellWithNib(
            identifier: String(describing: MeetingTableViewCell.self),bundle: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MeetingTableViewCell.self), for: indexPath) as! MeetingTableViewCell

        return cell
    }
}
