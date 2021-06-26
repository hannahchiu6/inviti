//
//  Localization+Extension.swift
//  inviti
//
//  Created by Hannah.C on 23.06.21.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension UILabel {

    func setLocalizedText(key: String) {
        self.text = key.localized
    }

    func setLocalizedText(key: String, arguments: [CVarArg]) {
        self.text = String(format: key.localized, arguments: arguments)
    }
}
