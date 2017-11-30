//
//  Event.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 30.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//
//

import Foundation

public class Event {

    var type: EventType!
    var status: EventStatus!
    var title: String!
    var text: String!
    var date: Date!
    var imagesHttpAddr: [String]!
    
    init(type: EventType, status: EventStatus, title: String, text: String,
         date: Date, arrayWithImagesURL: [String]) {
    
        self.type = type
        self.status = status
        self.title = title
        self.text = text
        self.date = date
        self.imagesHttpAddr = arrayWithImagesURL
            
    }
    
    convenience init() {
        self.init(type: .Undefined, status: .Unread, title: "Empty event", text: "Empty event",
                  date: Date(), arrayWithImagesURL: ["https://quitsmokingtogether.ru/images/97.jpg"])
    }
    
    func getFormattedDateFrom(stringWithDate: String, andTimezone timezone: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        if let formattedDate = dateFormatter.date(from: stringWithDate) {
            return formattedDate
        } else {
            return Date()
        }
    }
    
    enum EventType: String {
        case All = "All"
        case News = "News"
        case Competition = "Competition"
        case Undefined = "Undefined"
    }
    
    enum EventStatus: String {
        case All = "All"
        case Read = "Read"
        case Unread = "Unread"
        case Starred = "Starred"
    }
}

