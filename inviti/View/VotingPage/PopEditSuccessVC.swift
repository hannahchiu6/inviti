//
//  PopEditSuccessVC.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit

class PopEditSuccessVC: UIViewController {
    
    @IBOutlet weak var backBtnView: UIButton!
    
    @IBAction func returnMain(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
        print("PopEditSuccessVC!!!")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
