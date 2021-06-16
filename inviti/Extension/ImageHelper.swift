//
//  ImageHelper.swift
//  inviti
//
//  Created by Hannah.C on 20.05.21.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(_ urlString: String?, placeHolder: UIImage?) {
        
        guard urlString != nil else { return }
        
        guard let url = URL(string: urlString!) else { return }
        
        self.kf.setImage(with: url, placeholder: placeHolder)
        
        self.kf.setImage(with: ImageResource(downloadURL: url), placeholder: placeHolder, options: nil, progressBlock: nil, completionHandler: nil)
        
    }
}
