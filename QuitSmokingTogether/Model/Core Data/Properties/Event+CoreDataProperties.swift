//
//  Event+CoreDataProperties.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 30.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var title: String
    @NSManaged public var text: String
    @NSManaged public var typeRaw: String
    @NSManaged public var statusRaw: String
    @NSManaged public var imagesHttpAddr: [String]

}
