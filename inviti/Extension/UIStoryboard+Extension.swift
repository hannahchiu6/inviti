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
    
    static let voting = "Voting"
}

extension UIStoryboard {
    
    static var main: UIStoryboard { return uiStoryboard(name: StoryboardCategory.main) }
    
    static var meeting: UIStoryboard { return uiStoryboard(name: StoryboardCategory.meeting) }
    
    static var news: UIStoryboard { return uiStoryboard(name: StoryboardCategory.news) }
    
    static var calendar: UIStoryboard { return uiStoryboard(name: StoryboardCategory.calendar) }
    
    static var create: UIStoryboard { return uiStoryboard(name: StoryboardCategory.create) }
    
    static var settings: UIStoryboard { return uiStoryboard(name: StoryboardCategory.settings) }
    
    static var noti: UIStoryboard { return uiStoryboard(name: StoryboardCategory.noti) }
    
    static var second: UIStoryboard { return uiStoryboard(name: StoryboardCategory.second) }
    
    static var third: UIStoryboard { return uiStoryboard(name: StoryboardCategory.third) }
    
    static var voting: UIStoryboard { return uiStoryboard(name: StoryboardCategory.voting) }
    
    private static func uiStoryboard(name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
}
