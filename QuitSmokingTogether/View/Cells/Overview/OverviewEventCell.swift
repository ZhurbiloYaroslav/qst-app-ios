//
//  OverviewEventCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 21.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class OverviewEventCell: UITableViewCell {
    
    @IBOutlet weak var eventTypeImage: UIImageView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventTextLabel: UILabel!
    
    var currentEvent: Event!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCellFor(eventType: Event.EventType) {
        switch eventType {
        case .News:
            eventTypeImage.image = UIImage(named: "news.jpg")
        case .Competiton:
            eventTypeImage.image = UIImage(named: "competitions.jpg")
        default:
            eventTypeImage.image = UIImage(named: "placeHolder.png")
        }
        
        let event = EventsList.getFirstEventWithType(eventType, andStatus: .Unread)
        self.currentEvent = event
        
        eventImageView.downloadedFrom(link: event.arrayWithImagesURL[0], contentMode: .scaleAspectFill)
        eventTitleLabel.text = event.title
        eventTextLabel.text = event.text
    }

}
