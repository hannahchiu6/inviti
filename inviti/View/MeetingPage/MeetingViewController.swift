//
//  MeetingViewController.swift
//  inviti
//
//  Created by Hannah.C on 14.05.21.
//

import UIKit

class MeetingViewController: UIViewController {

    @IBAction func pastBtn(_ sender: Any) {

//            self.bottomLine.center.x = sender.center.x

    }

    @IBAction func futureBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.bottomLine.center.x = (sender as AnyObject).center.x
        }
    }

    let indicator = UIView()
    var indicatorCenterXContraint: NSLayoutConstraint?
    var selectedIndex: Int?

    @IBAction func notificationBtn(_ sender: Any) {
        showOptions(sender: sender as! UIButton)
//        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//           segue.destination.preferredContentSize = CGSize(width: 150, height: 200)
//           segue.destination.popoverPresentationController?.delegate = self
//

        }





    @IBOutlet weak var notificationIcon: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var pastLabel: UIButton!
    @IBOutlet weak var futureLabel: UIButton!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.do_registerCellWithNib(
            identifier: String(describing: MeetingTableViewCell.self),
            bundle: nil)
        setupView()
        
    }


//    @objc func userDidTouchButton(sender: UIButton) {
//
//        print("clicked!!!!!")
//        guard delegate?.shouldSelectedButton?(self, at: sender.tag) == true else { return }
//
//        UIView.animate(withDuration: 0.3) {
//            self.indicator.center.x = sender.center.x
//        }
//        delegate?.didSelectedButton?(self, at: sender.tag)
//
//        selectedIndex = sender.tag
//
//    }


    func setupView() {
    

        searchBar.backgroundImage = UIImage()
    }

    func showOptions(sender: UIButton) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "NotiViewController") {
          controller.modalPresentationStyle = .popover
          controller.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
          present(controller, animated: true, completion: nil)
        }
    }

}

//    private func setupIndicatorsViews() {
//
//        guard let dataSource = dataSource else { return }
//
//        selectedIndex = dataSource.initialButtonIndex(in: self)
//        let initialButton = stackView.arrangedSubviews[selectedIndex!]
//        indicator.translatesAutoresizingMaskIntoConstraints = false
//        indicator.backgroundColor = dataSource.colorOfIndicator(in: self)
//
//        addSubview(indicator)
//
//        NSLayoutConstraint.activate([
//            indicator.centerXAnchor.constraint(equalTo: initialButton.centerXAnchor),
//            indicator.bottomAnchor.constraint(equalTo: initialButton.bottomAnchor),
//            indicator.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / CGFloat(dataSource.numberOfButtons(in: self)) / 2),
//            indicator.heightAnchor.constraint(equalToConstant: 5),
//
//        ])
//
//
//        NSLayoutConstraint.activate([
//            stackView.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / CGFloat(dataSource.numberOfButtons(in: self)) / 2),
//            stackView.heightAnchor.constraint(equalToConstant: 2),
//
//        ])
//
//    }


extension MeetingViewController: UITableViewDataSource, UITableViewDelegate  {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MeetingTableViewCell.self), for: indexPath) as! MeetingTableViewCell

            return cell
        }
}


