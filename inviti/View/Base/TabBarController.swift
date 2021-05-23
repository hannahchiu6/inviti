//
//  TabBarController.swift
//  inviti
//
//  Created by Hannah.C on 12.05.21.
//
//
import UIKit

private enum Tab {

    case create

    case news

    case calendar

    case settings

    case main

    func controller() -> UIViewController {
        var controller: UIViewController

        switch self {
        case .create: controller = UIStoryboard.create.instantiateInitialViewController()!

        case .news: controller = UIStoryboard.news.instantiateInitialViewController()!

        case .calendar: controller = UIStoryboard.calendar.instantiateInitialViewController()!

        case .settings: controller = UIStoryboard.settings.instantiateInitialViewController()!

        case .main: controller = UIStoryboard.meeting.instantiateInitialViewController()!
        }

        controller.tabBarItem = tabBarItem()

        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0.0, bottom: -6.0, right: 0.0)

        return controller
    }

    func tabBarItem() -> UITabBarItem {
        switch self {
        case .create:
            return UITabBarItem(
                title: nil,
                image: UIImage(systemName: "plus.circle"),
                selectedImage: UIImage(systemName: "plus.circle.fill")
            )

        case .news:
            return UITabBarItem(
                title: nil,
                image: UIImage(systemName: "flame"),
                selectedImage: UIImage(systemName: "flame.fill")
            )

        case .calendar:
            return UITabBarItem(
                title: nil,
                image: UIImage(systemName: "calendar"),
                selectedImage: UIImage(systemName: "calendar")
            )

        case .settings:
            return UITabBarItem(
                title: nil,
                image: UIImage(systemName: "gearshape"),
                selectedImage: UIImage(systemName: "gearshape.fill")
            )

        case .main:
            return UITabBarItem(
                title: nil,
                image: UIImage(systemName: "rectangle.grid.1x2"),
                selectedImage: UIImage(systemName: "rectangle.grid.1x2.fill")
            )
        }
    }
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    private let tabs: [Tab] = [.main, .news, .create, .calendar, .settings]

    let centerButton = UIButton()

    var trolleyTabBarItem: UITabBarItem!

    var willBorder: Bool = false {
         didSet {
             if (willBorder) {
                 UIView.animate(withDuration: 1) { [weak self] () in
                    self?.centerButton.layer.borderColor = UIColor.black.cgColor
                    self?.centerButton.layer.borderWidth = 3
                 }
             } else {
                 centerButton.layer.borderColor = UIColor.clear.cgColor
                 centerButton.layer.borderWidth = 0
                 }
             }
     }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = tabs.map({ $0.controller() })

        settingButton()


    }

//    func layoutSubviews() {
//
//        let topBorder = UIView()
//
//        let borderHeight: CGFloat = 2

//        topBorder.lkBorderWidth = borderHeight
//        topBorder.lkBorderColor = .green
//        topBorder.frame = CGRect(x: 0, y: -1, width: view.frame.width, height: borderHeight)
//
//        self.tabBar.addSubview(topBorder)
//    }

    public func resetCenterBtn() {

        if self.selectedIndex == 2 {
         willBorder = !willBorder
        }

    }

    func settingButton() {
        let image = UIImage(named: "UIButtonBarNew.png")?.withTintColor(.white)
        centerButton.setImage(image, for: .normal)
        centerButton.frame.size = CGSize(width: 60, height: 60)
        centerButton.center = CGPoint(x: tabBar.bounds.midX, y: tabBar.bounds.midY - centerButton.frame.height / 3)
        centerButton.backgroundColor = UIColor(red: 1, green: 0.3647, blue: 0, alpha: 1.0)
        centerButton.layer.cornerRadius = centerButton.frame.width / 2

        centerButton.clipsToBounds = true
        centerButton.adjustsImageWhenHighlighted = false
        centerButton.addTarget(self, action: #selector(showH), for: .touchDown)
        centerButton.addTarget(self, action: #selector(showViewController), for: .touchUpInside)
        tabBar.addSubview(centerButton)
    }

    @objc func showViewController() {
        centerButton.backgroundColor = UIColor(red: 1, green: 0.3647, blue: 0, alpha: 1.0) /* #ff5d00 */
        self.selectedIndex = 2
        centerButton.layer.borderColor = UIColor.black.cgColor
        centerButton.layer.borderWidth = 3
        let storyBoard: UIStoryboard = UIStoryboard(name: "Create", bundle: nil)
        storyBoard.instantiateViewController(withIdentifier: "CreateFirstPageVC") as! CreateFirstPageVC
        resetCenterBtn()
    }

    @objc func showH() {
        centerButton.backgroundColor = UIColor.black

    }

    // MARK: - UITabBarControllerDelegate

    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
    ) -> Bool {
//        resetCenterBtn()
        guard let navVC = viewController as? UINavigationController,
              navVC.viewControllers.first is MeetingViewController
        else { return true }


            if let authVC = UIStoryboard.create.instantiateInitialViewController() {
                authVC.modalPresentationStyle = .overCurrentContext

                present(authVC, animated: false, completion: nil)
        }

        return true
    }
}
