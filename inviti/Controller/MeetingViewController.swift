//
//  MeetingViewController.swift
//  inviti
//
//  Created by Hannah.C on 14.05.21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import EasyRefresher

class MeetingViewController: BaseViewController {

    @IBAction func pastBtn(_ sender: UIButton) {
        sender.isSelected = true
        moveIndicatorView(reference: sender)
        futureView.isHidden = true
        pastView.isHidden = false
    }

    @IBAction func futureBtn(_ sender: UIButton) {
        sender.isSelected = true
        moveIndicatorView(reference: sender)
        futureView.isHidden = false
        pastView.isHidden = true
    }

    @IBOutlet weak var addMeetingPopView: UIView!

    @IBAction func addMeeting(_ sender: Any) {
        willPopup = !willPopup

    }

    @IBOutlet weak var futureView: UIView!
    @IBOutlet weak var pastView: UIView!
    @IBOutlet weak var indicatorCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var pastLabel: UIButton!
    @IBOutlet weak var futureLabel: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        addMeetingPopView.isHidden = true

        navigationController?.navigationBar.backgroundColor = UIColor.clear

        let vc = self.storyboard?.instantiateViewController(identifier: "MeetingVC") as? MeetingViewController
        self.view.window?.rootViewController = vc

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()

        self.tabBarController?.tabBar.isHidden = false
    }


    override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)

        self.tabBarController?.tabBar.isHidden = false

         }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(false)
    }

    private var willPopup = false {
        didSet {
            if (willPopup) {
                UIView.animate(withDuration: 1) { [weak self] () in

                    self?.addMeetingPopView.isHidden = false
                }
            } else {

                UIView.animate(withDuration: 1) { [weak self] () in
                    self?.addMeetingPopView.isHidden = true

                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addMeetingSegue" {
            let controller = segue.destination as! AddMeetingViewController

            controller.delegate = self

        }
    }

    let users: [User] = []

    var count: Int = 0

    private func moveIndicatorView(reference: UIView) {
        indicatorCenterXConstraint.isActive = false

        indicatorCenterXConstraint = bottomLine.centerXAnchor.constraint(equalTo: reference.centerXAnchor)

        indicatorCenterXConstraint.isActive = true

        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        })
    }

}

extension MeetingViewController: AddMeetingVCDelegate {
    func didtap() {
        addMeetingPopView.isHidden = true
    }
}
