//
//  SettingsTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    var viewModel = SettingsViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = UITableViewCell.SelectionStyle.none
        
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var nextImage: UIImageView!
    
    
    func setupEditCell(user: User, index: Int) {
        
        nextImage.image = UIImage(systemName: "chevron.down")
        
    }
}
