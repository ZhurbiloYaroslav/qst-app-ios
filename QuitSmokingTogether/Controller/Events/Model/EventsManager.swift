//
//  EventsManager.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 04.01.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import Alamofire

@objc protocol EventsManagerDelegate {
    @objc optional func didLoad(arrayWithEvents:[Event])
}

class EventsManager: NSObject {
    
    weak var delegate: EventsManagerDelegate?
    
    private var arrayWithEvents: [Event]!
    
    func retrieveInfoForPath(_ path: RequestAddress.ServerPath, completionHandler: @escaping (_ errorMessages: [NetworkError]?)->())  {
        
        var errorMessages = [NetworkError]()
        guard let url = path.getURL() else { return errorMessages.append(.badURL) }
        
        Alamofire.request(url).responseJSON { response in

            if let errorMessages = self.parseResultDataWith(response, andPath: path) {
                completionHandler(errorMessages)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func parseResultDataWith(_ response: DataResponse<Any>, andPath path: RequestAddress.ServerPath) -> [NetworkError]? {
        var errorMessages = [NetworkError]()
        
        switch path {
        case .events_all:
            parseEventsWith(response)
            return nil
        default:
            errorMessages.append(NetworkError.undefinedPath)
            return errorMessages
        }
    }
    
    func parseEventsWith(_ response: DataResponse<Any>) {

        arrayWithEvents = [Event]()
        guard let arrayWithEventsResult = response.result.value as? [(Dictionary<String, Any>)]  else {
            return
        }

        for dictWithResult in arrayWithEventsResult {
            let event = Event(withResult: dictWithResult)
            arrayWithEvents.append(event)
        }

        delegate?.didLoad?(arrayWithEvents: arrayWithEvents)

    }
    
    public struct RequestAddress {
        
        private enum Server: String {
            case production = ""
            case development = "http://qst.1gb.ua/"
        }
        
        public enum ServerPath: String {
            case events_all = "wp-json/wp/v2/posts?_embed"
            case users_all = "wp-json/wp/v2/users?_embed"
            case categories_all = "wp-json/wp/v2/categories?_embed"
            
            func getURL() -> URL? {
                var addressString = Server.development.rawValue
                addressString += "en/"
                addressString += self.rawValue
                return URL(string: addressString)
            }
        }
    }
    
    
    
    
    
    
    
//    static func getFirstEventWithType(_ type: Event.EventType, andStatus status: Event.EventStatus) -> Event {
//
//        if getAllEventsWithType(type, andStatus: status).count > 0 {
//            return getAllEventsWithType(type, andStatus: status)[0]
//        } else {
//            return Event()
//        }
//    }
    
//    static func getAllEventsWithType(_ type: Event.EventType, andStatus status: Event.EventStatus) -> [Event] {
//
//        var resultArrayWithEvents = [Event]()
//
//        for event in getArrayWithEvents() {
//            switch (type, status) {
//            case (.All, .All):
//                if event.type == .News || event.type == .Competition, event.status == .Unread || event.status == .Starred {
//                    resultArrayWithEvents.append(event)
//                }
//            case (.All, _):
//                if event.type == .News || event.type == .Competition, event.status == status {
//                    resultArrayWithEvents.append(event)
//                }
//            case (_, .All):
//                if event.type == type, event.status == .Unread || event.status == .Starred {
//                    resultArrayWithEvents.append(event)
//                }
//            default:
//                if event.type == type, event.status == status {
//                    resultArrayWithEvents.append(event)
//                }
//            }
//        }
//        return resultArrayWithEvents
//    }
    
//    static func getArrayWithEvents() -> [Event] {
//
//        if arrayWithEvents.count == 0 {
//            parseEventPlist()
//        }
//
//        return arrayWithEvents
//    }
    
//    static func parseEventPlist() {
//
//        guard let path = Bundle.main.path(forResource: "EventsList", ofType: "plist"),
//            let arrayWithEventsDictionaries = NSArray(contentsOfFile: path) as? [[String: Any]] else {
//                return
//        }
//
//        for eventDict in arrayWithEventsDictionaries {
//            createEventsFromParsedRow(eventDict)
//        }
//
//    }
    
//    static func createEventsFromParsedRow(_ eventDict: [String: Any]) {
//
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
//        let newEvent = Event(type: type, status: status,
//                             title: title, text: text,
//                             date: date, arrayWithImagesURL: arrayWithTrimmedImagesURL)
//
//        arrayWithEvents.append(newEvent)
//
//    }
    
}
