//
//  SettingsViewController.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    let titles: [String] = ["Name:", "Email:", "Upload your photo", "Language:", "Calendar"]
    let values: [String] = ["Moon Chiu", "moon2021@gmail.com", "", "English", "gmail"]
    let cellSpacingHeight: CGFloat = 5
    
    @IBAction func logout(_ sender: Any) {


            let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            print("logout success!")
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }

    }

    @IBOutlet weak var settingsTableView: UITableView!

    @IBOutlet weak var profilePhoto: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        profilePhoto.layer.cornerRadius = profilePhoto.bounds.width / 2

    }
}

extension SettingsViewController: UITableViewDelegate {

}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.titleLabel.text = titles[indexPath.row]
        cell.valueLabel.text = values[indexPath.row]

        return cell
    }

}
