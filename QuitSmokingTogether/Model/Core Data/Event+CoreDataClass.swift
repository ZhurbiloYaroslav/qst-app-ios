//
//  Event+CoreDataClass.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 30.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//
//

import Foundation
import CoreData

public class Event: NSManagedObject {

    var type: EventType {
        get {
            return EventType(rawValue: self.typeRaw) ?? EventType.Undefined
        }
        set {
            self.typeRaw = newValue.rawValue
        }
    }
    var status: EventStatus {
        get {
            return EventStatus(rawValue: self.statusRaw) ?? EventStatus.Unread
        }
        set {
            self.typeRaw = newValue.rawValue
        }
    }
    
    convenience init(needSave: Bool, type: EventType,
                     status: EventStatus, title: String,
                     text: String, arrayWithImagesURL: [String]) {
    
        let coreDataManager = CoreDataManager()
        let event = NSEntityDescription.entity(forEntityName: "Event", in: coreDataManager.context)!
    
        if(needSave) {
            self.init(entity: event, insertInto: coreDataManager.context)
        } else {
            self.init(entity: event, insertInto: nil)
        }
    
        self.type = type
        self.status = status
        self.title = title
        self.text = text
        self.imagesHttpAddr.append(contentsOf: arrayWithImagesURL)
    
    }
    
    convenience init() {
        self.init(needSave: false, type: .Undefined, status: .Unread,
                  title: "Empty event", text: "Empty event",
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

