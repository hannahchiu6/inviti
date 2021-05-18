//
//  CreateFirstPageVC.swift
//  inviti
//
//  Created by Hannah.C on 16.05.21.
//

import UIKit

class CreateFirstPageVC: UIViewController {

    weak var delegate: CreateFirstTableViewCell?
    
    @IBOutlet weak var confirmBtnView: UIButton!
    @IBAction func confirm(_ sender: Any) {
       performSegue(withIdentifier: "meetingSegue", sender: sender)
    }

    @IBOutlet weak var tableview: UITableView!

    @IBAction func nextPage(_ sender: Any) {
        nextPage() 

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
//        confirmBtnView.isEnabled = false
        
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
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreateFirstTableViewCell", for: indexPath) as! CreateFirstTableViewCell
        cell.delegate = self
        return cell
    }
}

extension CreateFirstPageVC: CreateFirstCellDelegate {
    func goToSecondPage() {
        nextPage()
    }
}
