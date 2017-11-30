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
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func update(event: Event) {
        
        eventImage.image = UIImage(named: "placeHolder.png")
        eventImage.downloadedFrom(link: event.imagesHttpAddr[0], contentMode: .scaleAspectFill)
        eventTitle.text = event.title
        eventDescription.text = event.text
        
    }
    
}
