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

    let viewModel = CreateMeetingViewModel()

    var willBorder: Bool = false {
         didSet {
             if (willBorder) {
                 UIView.animate(withDuration: 1) { [weak self] () in
                    self?.centerButton.layer.borderColor = UIColor.brown.cgColor
                    self?.centerButton.layer.borderWidth = 3
                 }
             } else {
                 centerButton.layer.borderColor = UIColor.clear.cgColor
                 centerButton.layer.borderWidth = 0
                 }
             }
    }


//                func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//                    print("Selected view controller", viewController)
//                    print("index", tabBarController.selectedIndex )
//
//                }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = tabs.map({ $0.controller() })

        settingButton()

        viewModel.meetingViewModels.bind { [weak self] meetings in
            self?.viewModel.onRefresh()
        }

    }

    private func relationshipSetup() {
        view.layoutIfNeeded()
        
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
//        self.selectedIndex == 3 || self.selectedIndex == 1 || self.selectedIndex == 0 || self.selectedIndex == 4 {
//            willBorder = !willBorder
//        }

    }

    func settingButton() {
        let image = UIImage(named: "UIButtonBarNew.png")?.withTintColor(.white)
        centerButton.setImage(image, for: .normal)
        centerButton.frame.size = CGSize(width: 60, height: 60)
        centerButton.center = CGPoint(x: tabBar.bounds.midX, y: tabBar.bounds.midY - centerButton.frame.height / 3)
        centerButton.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00)
        centerButton.layer.cornerRadius = centerButton.frame.width / 2

        centerButton.clipsToBounds = true
        centerButton.adjustsImageWhenHighlighted = false

        centerButton.addTarget(self, action: #selector(showH), for: .touchDown)
        centerButton.addTarget(self, action: #selector(showViewController), for: .touchUpInside)
        tabBar.addSubview(centerButton)
    }

    var onMeetingIDGet: ((String) -> Void)?
    

//    var onMeetingGet: ((CreateMeetingViewModel) -> Void)?

    @objc func showViewController() {

        centerButton.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00) /* #ff5d00 */
        self.selectedIndex = 2
        centerButton.layer.borderColor = UIColor.black.cgColor
        centerButton.layer.borderWidth = 3

    }

    @objc func showH() {
        centerButton.backgroundColor = UIColor.brown

        viewModel.create()

        onMeetingIDGet?(viewModel.meeting.id)

        viewModel.meeting.ownerAppleID = UserDefaults.standard.string(forKey: UserDefaults.Keys.uid.rawValue)!
//        UserDefaults.standard.setValue(UserDefaults.Keys.meetingID.rawValue, forKey: "viewModel.meeting.id")

        viewControllers?.forEach { vc in

            if let navVC = vc as? UINavigationController,
               let vc = navVC.viewControllers.first as? CreateFirstViewController {
                vc.meetingID = viewModel.meeting.id
                vc.createMeetingViewModel = viewModel
                vc.isDataEmpty = true
            }
        }
       
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
