//
//  EventsData.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 03.02.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class EventsData {
    
    static var shared = EventsData()
    
    private var arrayWithEvents = [Event]()
    
    private var networkManager = NetworkManager()
    
    public func getEventsFromServer(completionHandler: @escaping CompletionHandlerEmpty) {
        
        self.networkManager.get(.events) { resultData in
            switch resultData {
                
            case .withEvents(let arrayWithEvents):
                self.arrayWithEvents = self.sortEvents(arrayWithEvents)
                completionHandler()
                
            default:
                completionHandler()
            }
        }
    }
    
    public func getFirstEventWithType(_ type: Event.EventType, andStatus status: Event.EventStatus) -> Event {

        if getAllEventsWithType(type, andStatus: status).count > 0 {
            return getAllEventsWithType(type, andStatus: status)[0]
        } else {
            return Event()
        }
    }
    
    public func getAllEventsWithType(_ type: Event.EventType, andStatus status: Event.EventStatus) -> [Event] {

        var resultArrayWithEvents = [Event]()

        for event in getArrayWithEvents() {
            switch (type, status) {
            case (.All, .All):
                if event.type.contains(.News) || event.type.contains(.Competition), event.status == .Unread || event.status == .Starred {
                    resultArrayWithEvents.append(event)
                }
            case (.All, _):
                if event.type.contains(.News) || event.type.contains(.Competition), event.status == status {
                    resultArrayWithEvents.append(event)
                }
            case (_, .All):
                if event.type.contains(type), event.status == .Unread || event.status == .Starred {
                    resultArrayWithEvents.append(event)
                }
            default:
                if event.type.contains(type), event.status == status {
                    resultArrayWithEvents.append(event)
                }
            }
        }
        return resultArrayWithEvents
        
    }
    
    private func sortEvents(_ sourceArrayWithEvents: [Event]) -> [Event] {
        var result = [Event]()
        result = sourceArrayWithEvents.sorted { event1, event2 in
            return event1.getDate() > event2.getDate()
        }
        return result
    }

    public func getArrayWithEvents() -> [Event] {

        if arrayWithEvents.count == 0 {
            getEventsFromServer() {}
            return [Event]()
        }
        
        return arrayWithEvents
    }
    
}

extension EventsData {
    typealias CompletionHandlerWithErrors = (_ errorMessages: [NetworkError]?)->()
    typealias CompletionHandlerWithEvents = () -> ([Event])
    typealias CompletionHandlerEmpty = () -> ()
}


