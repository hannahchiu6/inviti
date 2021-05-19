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
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MeetingTableViewCell.self), for: indexPath) as! MeetingTableViewCell
        cell.delegate = self

        return cell
    }
}
extension PastTableViewController: MeetingTableCellDelegate {
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
