//
//  Event.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 23.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class Event {
    
    var type: EventType!
    var title: String!
    var text: String!
    var arrayWithImagesURL: [String]!
    
    init(type: EventType, title: String, text: String, arrayWithImagesURL: [String]) {
        self.type = type
        self.title = title
        self.text = text
        self.arrayWithImagesURL = arrayWithImagesURL
    }
    
    enum EventType: String {
        case All = "All"
        case News = "News"
        case Competiton = "Competition"
        case Undefined = "Undefined"
    }
}
