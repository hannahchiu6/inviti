//
//  InvitesTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 06.06.21.
//

import UIKit

class InvitesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        
    }

    @IBOutlet weak var ownerImage: UIImageView!

    @IBAction func waitButton(_ sender: Any) {
    }
    
    @IBOutlet weak var invitesLabel: UILabel!

    @IBAction func goVoteButton(_ sender: Any) {
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
