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
    var imagesHttpAddr: [String]!
    
    init(type: EventType, status: EventStatus, title: String, text: String, arrayWithImagesURL: [String]) {
    
        self.type = type
        self.status = status
        self.title = title
        self.text = text
        self.imagesHttpAddr = arrayWithImagesURL
            
    }
    
    convenience init() {
        self.init(type: .Undefined, status: .Unread, title: "Empty event", text: "Empty event",
                  arrayWithImagesURL: ["https://quitsmokingtogether.ru/images/97.jpg"])
    }
    
    enum EventType: String {
        case News = "News"
        case Competiton = "Competition"
        case Undefined = "Undefined"
    }
    
    enum EventStatus: String {
        case Read = "Read"
        case Unread = "Unread"
        case Starred = "Starred"
    }
}

