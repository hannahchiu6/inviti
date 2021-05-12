//
//  AddTabBar.swift
//  inviti
//
//  Created by Hannah.C on 12.05.21.
//

import UIKit

@IBDesignable
class AddTabBar: UITabBar {

    private var centerButton = UIButton()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCenterButton()
        UITabBar.appearance().barTintColor = UIColor(red: 0.9686, green: 0.8235, blue: 0, alpha: 1.0)
        UITabBar.appearance().tintColor = UIColor(red: 0.949, green: 0.6, blue: 0, alpha: 1.0)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden {
            return super.hitTest(point, with: event)
        }

        let aPoint = point
        let bPoint = centerButton.center

        return sqrt((aPoint.x - bPoint.x) * (aPoint.x - bPoint.x) + (aPoint.y - bPoint.y) * (aPoint.y - bPoint.y)) <= 39 ? centerButton : super.hitTest(point, with: event)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        centerButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
    }

    func setupCenterButton() {
        centerButton.frame.size = CGSize(width: 70, height: 70)
        centerButton.backgroundColor = UIColor(red: 0.9686, green: 0.8235, blue: 0, alpha: 1.0)
        centerButton.layer.cornerRadius = 35
        centerButton.layer.masksToBounds = true
        centerButton.layer.borderWidth = 2
        centerButton.layer.borderColor = UIColor(red: 0.949, green: 0.6, blue: 0, alpha: 1.0).cgColor
        centerButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
        centerButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        centerButton.addTarget(self, action: #selector(holdRelease), for: .touchDown)
        addSubview(centerButton)
        addCenterIcon()
    }

    func addCenterIcon() {
        let imageName = "ButtonPlus.png"
        let image = UIImage(named: imageName)?.withTintColor(.white)
        let imageView = UIImageView(image: image)
        imageView.frame.size = CGSize(width: 60, height: 60)
        imageView.center = CGPoint(x: centerButton.bounds.width / 2, y: centerButton.bounds.height / 2)

        centerButton.addSubview(imageView)
    }
    @objc func test() {
        print("Center Button Clicked")
        centerButton.backgroundColor = UIColor(red: 0.9686, green: 0.8235, blue: 0, alpha: 1.0)
    }
    @objc func holdRelease() {
        centerButton.backgroundColor = UIColor(red: 0.949, green: 0.6, blue: 0, alpha: 1.0)
    }
}
