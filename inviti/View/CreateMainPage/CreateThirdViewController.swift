//
//  CreateThirdViewController.swift
//  inviti
//
//  Created by Hannah.C on 16.05.21.
//

import UIKit
import SwiftyMenu
import JZCalendarWeekView

class CreateThirdViewController: UIViewController {
    private let items: [SwiftyMenuDisplayable] = ["30 分鐘", "60 分鐘", "1 小時", "2 小時", "3 小時", "4 小時", "自訂時間"]

    @IBAction func doneBtn(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("enableConfirmBtn"),
                                        object: self)
    }
    private let calendar: [SwiftyMenuDisplayable] = ["Tina Chen", "Lisa Chu", "Mary Huang", "Nina Schwaberg", "Coco Pods"]
    @IBAction func backBtn(_ sender: Any) {

        let vc = UIStoryboard(name: "Create", bundle: nil).instantiateViewController(withIdentifier: "CreateFirstPageVC")

        self.navigationController?.pushViewController(vc, animated: true)

    }
    @IBOutlet private weak var dropDown: SwiftyMenu!

    @IBOutlet private weak var calendarDropDown: SwiftyMenu!

    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.delegate = self
        dropDown.items = items
        calendarDropDown.delegate = self
        calendarDropDown.items = calendar
    }
}
extension CreateThirdViewController: SwiftyMenuDelegate {
    func swiftyMenu(_ swiftyMenu: SwiftyMenu, didSelectItem item: SwiftyMenuDisplayable, atIndex index: Int) {
        print("Selected item: \(item), at index: \(index)")
    }
}
