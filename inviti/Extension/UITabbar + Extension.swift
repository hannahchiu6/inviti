////
////  UITabbar + Extension.swift
////  inviti
////
////  Created by Hannah.C on 13.06.21.
////
//
//import UIKit
//
//fileprivate let lxfFlag: Int = 666
//
//extension UITabBar {
//    // MARK:- 顯示小紅點
//    func showBadgOn(index itemIndex: Int, tabbarItemNums: CGFloat = 4.0) {
//        // 移除之前的小紅點
//        self.removeBadgeOn(index: itemIndex)
//        // 建立小紅點
//        let bageView = UIView()
//        bageView.tag = itemIndex
//        bageView.layer.cornerRadius = 5
//        bageView.backgroundColor = UIColor.red
//        let tabFrame = self.frame
//
//        // 確定小紅點的位置
//        let percentX: CGFloat = (CGFloat(itemIndex)   0.59) / tabbarItemNums
//        let x: CGFloat = CGFloat(ceilf(Float(percentX * tabFrame.size.width)))
//        let y: CGFloat = CGFloat(ceilf(Float(0.115 * tabFrame.size.height)))
//        bageView.frame = CGRect(x: x, y: y, width: 10, height: 10)
//        self.addSubview(bageView)
//    }
//    // MARK:- 隱藏小紅點
//    func hideBadg(on itemIndex: Int) {
//    // 移除小紅點
//        self.removeBadgeOn(index: itemIndex)
//    }
//    // MARK:- 移除小紅點
//    fileprivate func removeBadgeOn(index itemIndex: Int) {
//    // 按照tag值進行移除
//        _ = subviews.map {
//            if $0.tag == itemIndex   lxfFlag {
//            $0.removeFromSuperview()
//            }
//        }
//    }
//}
//
//
