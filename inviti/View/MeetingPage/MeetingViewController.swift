//
//  MeetingViewController.swift
//  inviti
//
//  Created by Hannah.C on 14.05.21.
//

import UIKit

class MeetingViewController: UIViewController {

    private var willDrop: Bool = false {
        didSet {
            if (willDrop) {
                UIView.animate(withDuration: 1) { [weak self] () in
//                    let transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
                    self?.notiPopView.isHidden = false
//                    self?.notiPopView.transform = transform
                }
            } else {
                UIView.animate(withDuration: 1) { [weak self] () in
//                    let transform = CGAffineTransform.init(rotationAngle: CGFloat(0))
                    self?.notiPopView.isHidden = true
//                    self?.notiPopView.transform = transform
                }
            }
        }
    }


    var count: Int = 0

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

    @IBAction func notificationBtn(_ sender: Any) {
        willDrop = !willDrop
    }


    @IBOutlet weak var futureView: UIView!
    @IBOutlet weak var pastView: UIView!
    @IBOutlet weak var notiPopView: UIView!

    @IBOutlet weak var indicatorCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var notificationIcon: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var pastLabel: UIButton!
    @IBOutlet weak var futureLabel: UIButton!

    @IBOutlet weak var notiView: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        notiPopView.isHidden = true
        setupView()

        navigationController?.navigationBar.backgroundColor = UIColor.clear

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(false)
    }

    private func moveIndicatorView(reference: UIView) {
        indicatorCenterXConstraint.isActive = false

        indicatorCenterXConstraint = bottomLine.centerXAnchor.constraint(equalTo: reference.centerXAnchor)

        indicatorCenterXConstraint.isActive = true

        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        })
    }


    func setupView() {
        searchBar.backgroundImage = UIImage()
    }

//    func showOptions(sender: UIButton) {
//        if let controller = storyboard?.instantiateViewController(withIdentifier: "NotiViewController") {
//          controller.modalPresentationStyle = .popover
//          controller.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//          present(controller, animated: true, completion: nil)
//        }
//    }
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


