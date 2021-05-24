//
//  CalendarNibCell.swift
//  inviti
//
//  Created by Hannah.C on 24.05.21.
//

import UIKit

class CalendarNibCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var timeLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
