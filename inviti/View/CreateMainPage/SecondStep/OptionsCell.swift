//
//  OptionsCell.swift
//  inviti
//
//  Created by Hannah.C on 17.05.21.
//

import UIKit
import SwiftHEXColors

protocol SecondCellDelegate {
    func goToSecondPage()

}

class OptionsCell: UITableViewCell {

    @IBOutlet weak var optionsStackView: UIStackView!

    @IBOutlet weak var goSecondPage: UIButton!

    @IBOutlet weak var goSecondPageIcon: UIButton!

    @IBOutlet weak var bottomAlarmIcon: UIImageView!
    
    @IBAction func goNextPage(_ sender: Any) {
        delegate?.goToSecondPage()
    }


    @IBAction func goNextPageIcon(_ sender: Any) {
        delegate?.goToSecondPage()
    }

    var delegate: SecondCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
