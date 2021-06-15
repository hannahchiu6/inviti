//
//  EditViewController.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class EditViewController: UIViewController {

    let titles: [String] = ["August 8, Friday", "August 8, Friday", "August 8, Friday", "August 9, Saturday", "August 9, Saturday"]
    let start: [String] = ["11:00 - 13:00", "14:00 - 16:00", "17:00 - 19:00", "11:00 - 13:00", "17:00 - 19:00"]

    let cellSpacingHeight: CGFloat = 5
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var profilePhoto: UIImageView!

    @IBOutlet weak var popupView: UIView!

    @IBAction func sendMeeting(_ sender: Any) {

        UIView.animate(withDuration: 5.0, animations: { () -> Void in
            self.popupView.isHidden = false
            })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        popupView.isHidden = true

        profilePhoto.layer.cornerRadius = profilePhoto.bounds.width / 2

        popupView.shadowView(popupView)

        self.navigationController?.navigationBar.tintColor = UIColor.gray
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
    }

    override func viewWillAppear(_ animated: Bool) {
       self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       self.navigationController?.navigationBar.shadowImage = UIImage()
       self.navigationController?.navigationBar.isTranslucent = true
       }

   override func viewWillDisappear(_ animated: Bool) {
       self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       self.navigationController?.navigationBar.shadowImage = UIImage()
       self.navigationController?.navigationBar.isTranslucent = false
   }
}

extension EditViewController: UITableViewDelegate {

}

extension EditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "votingTableViewCell", for: indexPath) as! VotingTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.titleLabel.text = titles[indexPath.row]
        cell.valueLabel.text = start[indexPath.row]
        cell.checkBoxView.tag = indexPath.row

        return cell
    }

}
