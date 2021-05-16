//
//  CalendarViewController.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var eventTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()

        eventTableView.delegate = self
        eventTableView.dataSource = self

        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)

        eventTableView.register(nib, forCellReuseIdentifier: "eventTableViewCell")
    }

    func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        let rightButton = UIBarButtonItem(image: UIImage(named: "NotificationBell.png"), style: .plain, target: nil, action: nil)
        rightButton.tintColor = UIColor(red: 1, green: 0.3647, blue: 0, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = rightButton
    }
}

extension CalendarViewController: UITableViewDelegate {
}

extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCell(withIdentifier: "eventTableViewCell", for: indexPath) as! EventTableViewCell

//        cell.eventSubject = cellData[indexPath.row].0
//            cell.bgImageView.image = cellData[indexPath.row].1
        cell.eventSubject.text = "停電大作戰"
        cell.eventNotes.text = "趕緊衝手機充好充滿"

        return cell
    }
}
