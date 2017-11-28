//
//  EventVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 24.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import CLabsImageSlider

class EventVC: UIViewController, imageSliderDelegate {
    
    @IBOutlet weak var imageSlider: CLabsImageSlider!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    
    var currentEvent: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        
        updateLabels()
    }
    
    func setDelegates() {
        imageSlider.sliderDelegate = self
    }
    
    func updateLabels() {
        newsTitleLabel.text = currentEvent.title
        newsTextLabel.text = currentEvent.text
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageSlider.setUpView(imageSource: .Url(imageArray: currentEvent.arrayWithImagesURL, placeHolderImage: UIImage(named:"placeHolder")), slideType:.ManualSwipe, isArrowBtnEnabled: true)
    }
    
    func didMovedToIndex(index:Int) {
        print("did moved at Index : ",index)
    }

}
