//
//  UIButton+Extension.swift
//  inviti
//
//  Created by Hannah.C on 17.05.21.
//

import UIKit

class CheckBoxButton: UIButton {
    
    override func awakeFromNib() {
        self.setImage(UIImage(systemName: "checkmark.circle"), for: .selected)
        self.setImage(UIImage(systemName: "poweroff"), for: .normal)
        self.addTarget(self, action: #selector(CheckBoxButton.buttonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        self.isSelected = !self.isSelected
    }
    
}
