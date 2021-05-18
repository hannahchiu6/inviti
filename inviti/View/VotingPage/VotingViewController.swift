//
//  VotingViewController.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class VotingViewController: UIViewController {

    let titles: [String] = ["Name:", "Email:", "Upload your photo", "Language:", "Calendar"]
    let values: [String] = ["Moon Chiu", "moon2021@gmail.com", "", "English", "gmail"]
    let cellSpacingHeight: CGFloat = 5
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var profilePhoto: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        profilePhoto.layer.cornerRadius = profilePhoto.bounds.width / 2

    }
}

extension VotingViewController: UITableViewDelegate {

}

extension VotingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "votingTableViewCell", for: indexPath) as! VotingTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.titleLabel.text = titles[indexPath.row]
        cell.valueLabel.text = values[indexPath.row]

        return cell
    }

}
