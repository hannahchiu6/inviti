////
////  AddTabBar.swift
////  inviti
////
////  Created by Hannah.C on 12.05.21.
////
////
//import UIKit
//
//@IBDesignable
//class TabBarController: UITabBarController {
//
//    let centerButton = UIButton()
//
//    @IBOutlet weak var myTabBar: UITabBar!
//    override func viewDidLoad() {
//            super.viewDidLoad()
//            settingButton()
//
//        }
//
//        override func didReceiveMemoryWarning() {
//            super.didReceiveMemoryWarning()
//        }
//
//        override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(true)
//        }
//
//        override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//            if item.tag == 2 {
//                centerButton.layer.borderColor = UIColor.black.cgColor
//                centerButton.layer.borderWidth = 3
//
//            } else {
//                centerButton.backgroundColor = UIColor(red: 1, green: 0.3647, blue: 0, alpha: 1.0)
//                centerButton.layer.borderWidth = 0
//            }
//        }
//
//        func settingButton() {
//            let image = UIImage(named: "UIButtonBarNew.png")?.withTintColor(.white)
//            centerButton.setImage(image, for: .normal)
//            centerButton.frame.size = CGSize(width: 60, height: 60)
//            centerButton.center = CGPoint(x: tabBar.bounds.midX, y: tabBar.bounds.midY - centerButton.frame.height / 3)
//            centerButton.backgroundColor = UIColor(red: 1, green: 0.3647, blue: 0, alpha: 1.0)
//            centerButton.layer.cornerRadius = centerButton.frame.width / 2
//
//            centerButton.clipsToBounds = true
//            centerButton.adjustsImageWhenHighlighted = false
//            centerButton.addTarget(self, action: #selector(showViewController), for: .touchDown)
//
//            tabBar.addSubview(centerButton)
//        }
//
//        @objc func showViewController() {
//            centerButton.backgroundColor = UIColor(red: 1, green: 0.3647, blue: 0, alpha: 1.0) /* #ff5d00 */
//            self.selectedIndex = 2
//        }
//
//        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//            touches.forEach { (touch) in
//                let position = touch.location(in: tabBar)
//                let offset = centerButton.frame.height / 3
//                if centerButton.frame.minX <= position.x && position.x <= centerButton.frame.maxX {
//                    if centerButton.frame.minY - offset <= position.y && position.y <= centerButton.frame.maxY - offset{
//                        showViewController()
//                    }
//                }
//            }
//        }
//    }
