//
//  SettingsViewController.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    let cellSpacingHeight: CGFloat = 5

    var viewModel = SettingsViewModel()

    var userUID = UserDefaults.standard.value(forKey: UserDefaults.Keys.uid.rawValue) as? String ?? ""
    
    @IBAction func logout(_ sender: Any) {
        let firebaseAuth = Auth.auth()

        do {
          try firebaseAuth.signOut()
            print("logout success!")

        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }

    }

    @IBOutlet weak var settingsTableView: UITableView!

    @IBOutlet weak var profilePhoto: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var emailLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.fetchUserData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self

        viewModel.refreshView = { [weak self] () in
            DispatchQueue.main.async {
                self?.settingsTableView.reloadData()
            }
        }

        viewModel.userViewModel.bind { [weak self] user in
            self?.viewModel.onRefresh()
            self?.setupUpperView()
        }

    }

    func setupUpperView() {

        nameLabel.text = viewModel.userViewModel.value.name

        emailLabel.text = viewModel.userViewModel.value.email 

        guard let url = viewModel.userViewModel.value.image else { return }

            let imageUrl = URL(string: String(url))

            profilePhoto.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "moon.circle.fill"))

        profilePhoto.tintColor = UIColor.lightGray

        profilePhoto.layer.cornerRadius = profilePhoto.bounds.width / 2
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell", for: indexPath) as! SettingsTableViewCell

        cell.viewModel = viewModel

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let profileCell = tableView.cellForRow(at: indexPath),
           let destinationVC = navigationController?.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? UpdateProfileVC {

            destinationVC.viewModel = viewModel

            self.navigationController?.pushViewController(destinationVC, animated: true)
              }
    }

}
