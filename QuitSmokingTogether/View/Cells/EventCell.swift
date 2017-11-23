//
//  EventCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 23.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import CLabsImageSlider

class EventCell: UITableViewCell, imageSliderDelegate {
    
    @IBOutlet weak var imageSlider: CLabsImageSlider!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    func update(event: Event) {
        
        eventTitle.text = event.title
        eventDescription.text = event.text
        
        imageSlider.sliderDelegate = self
        imageSlider.setUpView(imageSource: .Url(imageArray: event.images, placeHolderImage: UIImage(named:"Man")), slideType:.ManualSwipe, isArrowBtnEnabled: true)
        
        // imageSlider.setUpView(.Local(imageArray: localImages),slideType: .ManualSwipe,isArrowBtnEnabled: true)
    }
    
    func didMovedToIndex(index:Int) {
        print("did moved at Index : ",index)
    }
    
}
