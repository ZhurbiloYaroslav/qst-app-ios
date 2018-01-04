//
//  EventsList.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 24.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class EventsList {
    
    static var arrayWithEvents: [Event] = [Event]()
    
    static func getFirstEventWithType(_ type: Event.EventType, andStatus status: Event.EventStatus) -> Event {

        if getAllEventsWithType(type, andStatus: status).count > 0 {
            return getAllEventsWithType(type, andStatus: status)[0]
        } else {
            return Event()
        }
    }
    
    static func getAllEventsWithType(_ type: Event.EventType, andStatus status: Event.EventStatus) -> [Event] {
        
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
    
    static func getArrayWithEvents() -> [Event] {
        
        if arrayWithEvents.count == 0 {
            parseEventPlist()
        }

        return arrayWithEvents
    }
    
    static func parseEventPlist() {
        
        guard let path = Bundle.main.path(forResource: "EventsList", ofType: "plist"),
            let arrayWithEventsDictionaries = NSArray(contentsOfFile: path) as? [[String: Any]] else {
                return
        }
        
        for eventDict in arrayWithEventsDictionaries {
            createEventsFromParsedRow(eventDict)
        }
        
    }
    
    static func createEventsFromParsedRow(_ eventDict: [String: Any]) {
        
//        guard let typeRaw = eventDict["Type"] as? String else { return }
//        guard let statusRaw = eventDict["Status"] as? String else { return }
//        guard let title = eventDict["Title"] as? String else { return }
//        guard let text = eventDict["Text"] as? String else { return }
//        guard let date = eventDict["Date"] as? Date else { return }
//        
//        guard let type = Event.EventType(rawValue: typeRaw) else { return }
//        guard let status = Event.EventStatus(rawValue: statusRaw) else { return }
//        guard let imagesText = eventDict["Images"] as? String else { return }
//        
//        let arrayWithImagesURL = imagesText.components(separatedBy: ",")
//        
//        var arrayWithTrimmedImagesURL = [String]()
//        
//        for image in arrayWithImagesURL {
//            let trimmedImage = image.trimmingCharacters(in: .whitespacesAndNewlines)
//            arrayWithTrimmedImagesURL.append(trimmedImage)
//        }
//        
////        let newEvent = Event(type: type, status: status,
////                             title: title, text: text,
////                             date: date, arrayWithImagesURL: arrayWithTrimmedImagesURL)
////
////        arrayWithEvents.append(newEvent)
        
    }
}
