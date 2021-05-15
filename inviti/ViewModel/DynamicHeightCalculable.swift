//
//  DynamicHeightCalculable.swift
//  inviti
//
//  Created by Hannah.C on 14.05.21.
//

import UIKit

protocol DynamicHeightCalculable {
    func height(forWidth: CGFloat) -> CGFloat
}

func calculateHeighest<T: DynamicHeightCalculable>(with viewModels: [T], forWidth width: CGFloat) -> T? {
    var largestViewModel = viewModels.first
    var largestHeight: CGFloat = 0

    for viewModel in viewModels {
        let height = viewModel.height(forWidth: width)

        if height > largestHeight {
            largestHeight =  height
            largestViewModel = viewModel
        }
    }

    return largestViewModel
}
