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
    @IBOutlet weak var eventStarredButton: StarButton!
    
    var currentEvent: Event!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateWith(_ event: Event) {
        
        currentEvent = event
        eventImage.image = UIImage(named: "placeHolder.png")
        eventTitle.text = event.title
        eventDescription.text = event.textContent
        
        if event.arrayWithImageLinks.count > 0 {
            eventImage.sd_setImage(with: URL(string: event.arrayWithImageLinks[0]), placeholderImage: #imageLiteral(resourceName: "bookCover"))
        }
        
        eventStarredButton.makeButtonActiveIfActive(currentEvent)
        
    }
    
    @IBAction func starredButtonPressed(_ sender: UIButton) {
        eventStarredButton.starredButtonPressedFor(currentEvent)
    }
    
}
