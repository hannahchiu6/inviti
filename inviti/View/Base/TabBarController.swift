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
    
    var newsTabBarItem: UITabBarItem!
    
    let viewModel = CreateMeetingViewModel()
    
    var userUID = UserDefaults.standard.string(forKey: UserDefaults.Keys.uid.rawValue) ?? ""
    
    var willBorder: Bool = false {
        didSet {
            if willBorder {
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
    
    var newValue: [NotificationViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = tabs.map({ $0.controller() })
        
        settingButton()
        
        addcoustmeTabBarView()
        
        viewModel.meetingViewModels.bind { [weak self] meetings in
            self?.viewModel.onRefresh()
        }
        
        
        newsTabBarItem = viewControllers?[1].tabBarItem
        
        newsTabBarItem.badgeColor = UIColor(red: 0.5804, green: 0.3922, blue: 0.2314, alpha: 1.0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(newsUpdated), name: NSNotification.Name(rawValue: "newsUpdated"), object: nil)
    }
    
    @objc func newsUpdated(_ notification: NSNotification) {
        
        guard let newValue = self.newValue else { return }
        
        if newValue.isEmpty {
            
            self.newsTabBarItem.badgeValue = nil
            
        } else {
            
            self.newsTabBarItem.badgeValue = String(newValue.count)
        }
        
    }
    
    private func relationshipSetup() {
        view.layoutIfNeeded()
        
    }
    
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
        centerButton.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00)
        centerButton.layer.cornerRadius = centerButton.frame.width / 2
        
        centerButton.clipsToBounds = true
        centerButton.adjustsImageWhenHighlighted = false
        
        centerButton.addTarget(self, action: #selector(showH), for: .touchDown)
        centerButton.addTarget(self, action: #selector(showViewController), for: .touchUpInside)
        tabBar.addSubview(centerButton)
    }
    
    var onMeetingIDGet: ((String) -> Void)?
    
    @objc func showViewController() {
        
        centerButton.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.26, alpha: 1.00) /* #ff5d00 */
        self.selectedIndex = 2
        centerButton.layer.borderColor = UIColor.black.cgColor
        centerButton.layer.borderWidth = 3
        
    }
    
    @objc func showH() {
        centerButton.backgroundColor = UIColor.brown
        
        viewModel.create()
        
        let meetingID = viewModel.meeting.id
        
        onMeetingIDGet?(meetingID)
        
        viewModel.meeting.ownerAppleID = userUID
        
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
        
        guard let navVC = viewController as? UINavigationController,
              navVC.viewControllers.first is MeetingViewController
        else { return true }
        
        
        if let authVC = UIStoryboard.create.instantiateInitialViewController() {
            authVC.modalPresentationStyle = .overCurrentContext
            
            present(authVC, animated: false, completion: nil)
        }
        
        return true
    }
    
    private func addcoustmeTabBarView() {
        
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        tabBar.layer.shadowRadius = 10
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.masksToBounds = false
        
    }
    
}
