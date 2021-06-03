////
////  VotingResutlsVC.swift
////  inviti
////
////  Created by Hannah.C on 13.05.21.
////
//
//import UIKit
//
//class VotingResutlsVC: UIViewController {
//
//    @IBOutlet weak var tableView: UITableView!
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//
//    func setupView() {
//        tableviewBG.layer.cornerRadius = 5
//        tableviewBG.layer.shadowColor = UIColor.black.cgColor
//        tableviewBG.layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
//        tableviewBG.layer.shadowRadius = 8
//        tableviewBG.layer.shadowOpacity = 0.2
//        tableviewBG.layer.masksToBounds = false
//        background.frame = CGRect(x: 0 , y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.4)
//    }
//}
//
//extension VotingResutlsVC: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return info[section].count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TopNewsTableViewCell", for: indexPath) as! TopNewsTableViewCell
//
//            cell.topNewsLabel.text = "\(info[indexPath.section][indexPath.row])"
//
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsEventTableViewCell", for: indexPath) as! NewsEventTableViewCell
//            cell.subtitleLabel.text = " 08:00 - 12:00 "
//            cell.countLabel.text = "和其他 768 人參加"
//            cell.subjectLabel.text = "\(info[indexPath.section][indexPath.row])"
//
//            return cell
//        }
//    }
//
//    // 點選 cell 後執行的動作
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        let name = info[indexPath.section][indexPath.row]
//        print("選擇的是 \(name)")
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return info.count
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let title = section == 0 ? "本月最受歡迎活動 TOP 10" : "最熱門的投票議題，來去參與！"
//        return title
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return 28
//        } else {
//            return CGFloat(Int(view.frame.height / 6.5))
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if let headerView = view as? UITableViewHeaderFooterView {
//            headerView.contentView.backgroundColor = .white
//            headerView.backgroundView?.backgroundColor = .black
//            headerView.textLabel?.textColor = .black
//            headerView.textLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
//            headerView.textLabel?.center.x = view.center.x
//        }
//    }
//}
