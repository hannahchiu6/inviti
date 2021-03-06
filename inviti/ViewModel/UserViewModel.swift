//
//  UserViewModel.swift
//  inviti
//
//  Created by Hannah.C on 03.06.21.
//

import Foundation

class UserViewModel {
    var user: User
    
    init(model user: User) {
        self.user = user
    }
    
    var id: String {
        return user.id
    }
    
    var name: String? {
        return user.name
    }
    
    var email: String? {
        return user.email
    }
    
    var image: String? {
        return user.image
    }
    
    var phone: String? {
        return user.phone
    }
    
    var address: String? {
        return user.address
    }
    
    var isCalendarSynced: Bool? {
        return user.isCalendarSynced
    }
    
    var numOfMeetings: Int? {
        return user.numOfMeetings
    }
    
    var calendarType: String? {
        return user.calendarType
    }
    
    var numberForSearch: String {
        return user.numberForSearch
    }
    
}
