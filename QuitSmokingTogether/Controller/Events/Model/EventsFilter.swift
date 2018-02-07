//
//  EventsFilter.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 30.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class EventsFilter {
    
    static var shared = EventsFilter()
    
    var eventType: Event.EventType!
    var eventStatus: Event.EventStatus!
    
    init(type: Event.EventType, status: Event.EventStatus) {
        self.eventType = type
        self.eventStatus = status
    }
    
    convenience init() {
        self.init(type: .All, status: .All)
    }
}
