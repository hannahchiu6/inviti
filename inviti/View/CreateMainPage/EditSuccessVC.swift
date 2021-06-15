//
//  EditSuccessVC.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit

protocol EditSuccessVCDelegate: AnyObject {
    func didTapReturnButton()
}

class EditSuccessVC: BaseViewController {

    weak var delegate: EditSuccessVCDelegate?

    @IBAction func backToMain(_ sender: Any) {

        delegate?.didTapReturnButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
