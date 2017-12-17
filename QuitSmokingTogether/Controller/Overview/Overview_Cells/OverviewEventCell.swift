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
    @IBOutlet weak var readMoreButton: UIButton!
    
    var currentEvent: Event!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    enum ReadMoreButtonTag: Int {
        case News = 0
        case Competitions = 1
    }
    
    func updateCellFor(eventType: Event.EventType) {
        switch eventType {
        case .News:
            eventTypeImage.image = UIImage(named: "news.jpg")
            readMoreButton.tag = ReadMoreButtonTag.News.rawValue
        case .Competition:
            eventTypeImage.image = UIImage(named: "competitions.jpg")
            readMoreButton.tag = ReadMoreButtonTag.Competitions.rawValue
        default:
            eventTypeImage.image = UIImage(named: "placeHolder.png")
        }
        
        let event = EventsList.getFirstEventWithType(eventType, andStatus: .Unread)
        self.currentEvent = event
        
        eventImageView.downloadedFrom(link: event.imagesHttpAddr[0], contentMode: .scaleAspectFill)
        eventTitleLabel.text = event.title
        eventTextLabel.text = event.text
    }
    
    @IBAction func readMoreButtonPressed(_ sender: UIButton) {
        
    }
    
}
