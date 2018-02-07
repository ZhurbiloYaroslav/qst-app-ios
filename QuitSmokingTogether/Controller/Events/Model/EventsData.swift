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
    
    func getEventsFromServer(completionHandler: @escaping CompletionHandlerWithData) {
        
        self.networkManager.get(.events) { resultData in
            switch resultData {
                
            case .withEvents(let arrayWithEvents):
                self.arrayWithEvents = arrayWithEvents
                let resultData = ResultData.withEvents(arrayWithEvents)
                completionHandler(resultData)
                
            default:
                let resultData = ResultData.withErrors([NetworkError.undefined])
                completionHandler(resultData)
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
                if event.type == .News || event.type == .Competition, event.status == .Unread || event.status == .Starred {
                    resultArrayWithEvents.append(event)
                }
            case (.All, _):
                if event.type == .News || event.type == .Competition, event.status == status {
                    resultArrayWithEvents.append(event)
                }
            case (_, .All):
                if event.type == type, event.status == .Unread || event.status == .Starred {
                    resultArrayWithEvents.append(event)
                }
            default:
                if event.type == type, event.status == status {
                    resultArrayWithEvents.append(event)
                }
            }
        }
        return resultArrayWithEvents
    }

    func getArrayWithEvents() -> [Event] {

        if arrayWithEvents.count == 0 {
            getEventsFromServer() { errors in
                return self.arrayWithEvents
            }
        }

        return arrayWithEvents
    }
    
}

extension EventsData {
    typealias CompletionHandlerWithErrors = (_ errorMessages: [NetworkError]?)->()
}


