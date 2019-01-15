//
//  EventsManager.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 04.01.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import Alamofire

class EventsManager: NSObject {
    
    public static let shared = EventsManager()
    
    public let eventsFilter = EventsFilter.shared
    
    public let eventsData = EventsData.shared
    
    func getNumberOfEvents() -> Int {
        return eventsData.getArrayWithEvents().count
    }
    
    public func getNewsByPostID(_ postIDs: [Int]) -> QSTEvent? {
        var resultEvent: QSTEvent? = nil
        eventsData.getArrayWithEvents().forEach { event in
            if postIDs.contains(event.getPostID()) {
                resultEvent = event
            }
        }
        return resultEvent
    }
    
    func getEventFor(_ indexPath: IndexPath) -> QSTEvent {
        return eventsData.getArrayWithEvents()[indexPath.row]
    }
    
    //        arrayWithEvents = EventsList.getAllEventsWithType(eventsFilter.eventType, andStatus: eventsFilter.eventStatus)
    
}
