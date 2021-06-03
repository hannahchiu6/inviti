//
//  Box.swift
//  Publisher
//
//  Created by Wayne Chen on 2020/11/20.
//

import Foundation

/**
 From raywenderlich: https://www.raywenderlich.com/6733535-ios-mvvm-tutorial-refactoring-from-mvc#toc-anchor-008
 */
final class Box<T> {

      typealias Listener = (T) -> Void

    var listeners = [Listener?]()

      init(_ value: T) {
        self.value = value
      }

    var value: T {
      didSet {
          listeners.forEach { listener in
              listener?(value)
          }
      }
    }

  func bind(listener: Listener?) {
    listeners.append(listener)
    listeners.forEach { listener in
        listener?(value)
    }
  }

   func unbind(listener: Listener?) {
        self.listeners = self.listeners.filter { $0 as
            AnyObject !== listener as AnyObject

        }
    }

}


