//
//  CreateFirstPageVC.swift
//  inviti
//
//  Created by Hannah.C on 16.05.21.
//

import UIKit

class CreateFirstPageVC: UIViewController {

    weak var delegate: CreateFirstCell?
    
    @IBOutlet weak var confirmBtnView: UIButton!
    
    @IBAction func confirm(_ sender: Any) {
//       performSegue(withIdentifier: "meetingSegue", sender: sender)
        UIView.animate(withDuration: 5.0, animations: { () -> Void in
            self.popupView.isHidden = false
            })
    }

    @IBOutlet weak var popupView: UIView!

    @IBOutlet weak var tableview: UITableView!

    @IBAction func nextPage(_ sender: Any) {
        nextPage() 

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
//        confirmBtnView.isEnabled = false

        self.popupView.isHidden = true
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(enableConfirmBtn),
                                               name: Notification.Name("enableConfirmBtn"),
                                               object: nil)
    }


    @objc func enableConfirmBtn(noti: Notification) {
        confirmBtnView.isEnabled = true
        confirmBtnView.backgroundColor = .blue
        confirmBtnView.isHidden = true
    }

    func nextPage() {
        let secondVC = storyboard?.instantiateViewController(identifier: "SecondVC")
           guard let second = secondVC as? CreateSecondVC else { return }

           navigationController?.pushViewController(second, animated: true)
    }
}
extension CreateFirstPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section  {
        case 0:
            return 1

        case 2:
          return 1

        default:
            return 1
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section  {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreateFirstTableViewCell", for: indexPath) as! CreateFirstCell
            cell.delegate = self
            return cell

        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionalSettingsCell", for: indexPath) as! OptionalSettingsCell

            return cell

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell", for: indexPath) as! OptionsCell

            return cell
        }
    }

}

extension CreateFirstPageVC: CreateFirstCellDelegate {
    func goToSecondPage() {
        nextPage()
    }
}
