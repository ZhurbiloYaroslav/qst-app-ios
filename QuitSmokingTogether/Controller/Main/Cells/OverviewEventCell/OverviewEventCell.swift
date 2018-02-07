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
            readMoreButton.tag = ReadMoreButtonTag.News.rawValue
        case .Competition:
            readMoreButton.tag = ReadMoreButtonTag.Competitions.rawValue
        default:
            break
        }
        
        let event = EventsData.shared.getFirstEventWithType(eventType, andStatus: .Unread)
        self.currentEvent = event
        
        eventTitleLabel.text = event.title
        eventTextLabel.text = event.textContent
        
        if event.arrayWithImageLinks.count > 0 {
            eventImageView.sd_setImage(with: URL(string: event.arrayWithImageLinks[0]), placeholderImage: #imageLiteral(resourceName: "bookCover"))
        }
    }
    
    @IBAction func readMoreButtonPressed(_ sender: UIButton) {
        
    }
    
}
