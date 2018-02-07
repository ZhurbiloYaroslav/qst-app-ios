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
    
    private var eventsData = EventsData.shared
    public var eventsFilter = EventsFilter.shared
    
    func getEventsFromServer() {
        eventsData.getEventsFromServer { (arrayWithMessages) in
            print(self.eventsData.arrayWithEvents)
        }
    }
    
    //        arrayWithEvents = EventsList.getAllEventsWithType(eventsFilter.eventType, andStatus: eventsFilter.eventStatus)
    
}
