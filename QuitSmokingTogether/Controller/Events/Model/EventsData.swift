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
    
    public var arrayWithEvents = [Event]()
    
    var networkManager = NetworkManager()
    
    func getEventsFromServer(completionHandler: @escaping CompletionHandlerEmpty) {
        
        self.networkManager.get(.events) { resultData in
            switch resultData {
                
            case .withEvents(let arrayWithEvents):
                self.arrayWithEvents = arrayWithEvents
                completionHandler()
                
            default:
                completionHandler()
            }
        }
    }
    
    func getFirstEventWithType(_ type: Event.EventType, andStatus status: Event.EventStatus) -> Event {

        if getAllEventsWithType(type, andStatus: status).count > 0 {
            return getAllEventsWithType(type, andStatus: status)[0]
        } else {
            return Event()
        }
    }
    
    func getAllEventsWithType(_ type: Event.EventType, andStatus status: Event.EventStatus) -> [Event] {

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

    func getArrayWithEvents() -> [Event] {

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


