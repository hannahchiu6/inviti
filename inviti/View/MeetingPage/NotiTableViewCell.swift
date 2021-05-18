//
//  NotiTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 16.05.21.
//

import UIKit

class NotiTableViewCell: UITableViewCell {

    @IBAction func ignore(_ sender: Any) {
    }
    @IBAction func accept(_ sender: Any) {
    }
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var personImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        personImg.layer.cornerRadius =  personImg.frame.width / 2

    }
}
