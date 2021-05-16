//
//  NewsViewController.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class NewsViewController: UIViewController {

    var info = [
    ["1. 疫苗篩檢","2. 報稅活動","3. 大安森林公園","4. 新生報到怎麼約","5. 汽車駕訓班","6. 浮淺教練執照三級考試", "7. 鐵人三項", "8. 澎湖旅行", "9. 下午茶訂購", "10. 喜酒婚宴"],
        ["哪個動物喜歡群聚？","你打疫苗了沒？", "誰來晚餐最想邀請哪個明星？", "你是夜貓族嗎？", "熬夜會不會傷身？", "你最想要擁有哪項超能力？", "哪個月份你最喜歡？"]]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableviewBG: UIView!
    @IBOutlet var background: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func setupView() {
        tableviewBG.layer.cornerRadius = 5
        tableviewBG.layer.shadowColor = UIColor.black.cgColor
        tableviewBG.layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        tableviewBG.layer.shadowRadius = 8
        tableviewBG.layer.shadowOpacity = 0.2
        tableviewBG.layer.masksToBounds = false
        background.frame = CGRect(x: 0 , y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.4)
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info[section].count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopNewsTableViewCell", for: indexPath) as! TopNewsTableViewCell

            cell.topNewsLabel.text = "\(info[indexPath.section][indexPath.row])"

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsEventTableViewCell", for: indexPath) as! NewsEventTableViewCell
            cell.subtitleLabel.text = " 08:00 - 12:00 "
            cell.countLabel.text = "和其他 768 人參加"
            cell.subjectLabel.text = "\(info[indexPath.section][indexPath.row])"

            return cell
        }
    }

    // 點選 cell 後執行的動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let name = info[indexPath.section][indexPath.row]
        print("選擇的是 \(name)")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return info.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = section == 0 ? "本月最受歡迎活動 TOP 10" : "最熱門的投票議題，來去參與！"
        return title
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 28
        } else {
            return CGFloat(Int(view.frame.height / 6.5))
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .white
            headerView.backgroundView?.backgroundColor = .black
            headerView.textLabel?.textColor = .black
            headerView.textLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
            headerView.textLabel?.center.x = view.center.x
        }
    }
}
