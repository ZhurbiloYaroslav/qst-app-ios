//
//  EventCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 23.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var readMoreLabel: UILabel!
    @IBOutlet weak var eventStarredButton: StarButton!
    
    var currentEvent: Event!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        readMoreLabel.setRadius(10, withWidth: 1, andColor: UIColor.clear)
    }
    
    func updateWith(_ event: Event) {
        
        currentEvent = event
        eventTitle.text = event.title
        eventDescription.text = event.textContent
        readMoreLabel.text = "button_readmore".localized()
        
        if event.arrayWithImageLinks.count > 0 {
            eventImage.sd_setImage(with: URL(string: event.arrayWithImageLinks[0]), placeholderImage: UIImage())
        }
        
        eventStarredButton.makeButtonActiveIfActive(currentEvent)
        
    }
    
    @IBAction func starredButtonPressed(_ sender: UIButton) {
        eventStarredButton.starredButtonPressedFor(currentEvent)
    }
    
}
