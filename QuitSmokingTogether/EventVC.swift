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
    
    var eventToSwitch: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        
        updateLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let event = eventToSwitch {
            print(event.title)
        }
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
        
        imageSlider.setUpView(imageSource: .Url(imageArray: currentEvent.imagesHttpAddr, placeHolderImage: UIImage(named:"placeHolder")), slideType:.Automatic(timeIntervalinSeconds: 5), isArrowBtnEnabled: true)
    }
    
    func didMovedToIndex(index:Int) {

    }

}
