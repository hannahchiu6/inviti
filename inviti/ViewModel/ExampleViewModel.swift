//
//  ExampleViewModel.swift
//  inviti
//
//  Created by Hannah.C on 14.05.21.
//

import UIKit

struct ExampleViewModel: DynamicHeightCalculable {

    let title: String
    let body: String?

    init(example: ExampleModel) {
        title = example.title
        body = example.body
    }

    public func height(forWidth width: CGFloat) -> CGFloat {
        let sizingLabel = UILabel()
        sizingLabel.numberOfLines = 0
        sizingLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        sizingLabel.lineBreakMode = .byTruncatingTail
        sizingLabel.text = body

        let maxSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = sizingLabel.sizeThatFits(maxSize)

        return size.height
    }

}

