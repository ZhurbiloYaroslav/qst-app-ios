//
//  Event.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 23.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class Event {
    
    var title: String!
    var text: String!
    var images: [String]!
    
    init(title: String, text: String, images: [String]) {
        self.title = title
        self.text = text
        self.images = images
    }
    
    enum EventType: String {
        case News = "News"
        case Competiton = "Competition"
    }
}
