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
    
    var eventType: QSTEvent.EventType!
    var eventStatus: QSTEvent.EventStatus!
    
    init(type: QSTEvent.EventType, status: QSTEvent.EventStatus) {
        self.eventType = type
        self.eventStatus = status
    }
    
    convenience init() {
        self.init(type: .All, status: .All)
    }
}
