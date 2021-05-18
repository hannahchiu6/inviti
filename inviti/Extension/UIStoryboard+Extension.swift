//
//  UIStoryboard+Extension.swift
//  inviti
//
//  Created by Hannah.C on 14.05.21.
//

import Foundation

import UIKit

private struct StoryboardCategory {
    static let main = "Main"

    static let news = "News"

    static let calendar = "Calendar"

    static let create = "Create"

    static let settings = "Settings"

    static let noti = "Notification"

    static let meeting = "Meeting"

    static let second = "Second"

    static let third = "Third"
}

extension UIStoryboard {

    static var main: UIStoryboard { return stStoryboard(name: StoryboardCategory.main) }

    static var meeting: UIStoryboard { return stStoryboard(name: StoryboardCategory.meeting) }

    static var news: UIStoryboard { return stStoryboard(name: StoryboardCategory.news) }

    static var calendar: UIStoryboard { return stStoryboard(name: StoryboardCategory.calendar) }

    static var create: UIStoryboard { return stStoryboard(name: StoryboardCategory.create) }

    static var settings: UIStoryboard { return stStoryboard(name: StoryboardCategory.settings) }

    static var noti: UIStoryboard { return stStoryboard(name: StoryboardCategory.noti) }

    static var second: UIStoryboard { return stStoryboard(name: StoryboardCategory.second) }

    static var third: UIStoryboard { return stStoryboard(name: StoryboardCategory.third) }

    private static func stStoryboard(name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
}
