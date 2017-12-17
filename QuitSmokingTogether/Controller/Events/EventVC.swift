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
    @IBOutlet weak var starredButton: StarButton!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    
    var currentEvent: Event!
    
    var eventToSwitch: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNavigationTitle()
        setDelegates()
        updateLabels()
    }
    
    func updateNavigationTitle() {
        if let event = currentEvent {
            switch event.type {
            case .News:
                navigationItem.title = "News info"
            case .Competition:
                navigationItem.title = "Competition info"
            default:
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setDelegates() {
        imageSlider.sliderDelegate = self
    }
    
    func updateLabels() {
        newsTitleLabel.text = currentEvent.title
        newsTextLabel.text = currentEvent.text
        
        starredButton.makeButtonActiveIfActive(currentEvent)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
                
        imageSlider.setUpView(imageSource: .Url(imageArray: currentEvent.imagesHttpAddr, placeHolderImage: UIImage(named:"placeHolder")), slideType:.Automatic(timeIntervalinSeconds: 5), isArrowBtnEnabled: true)
    }
    
    func didMovedToIndex(index:Int) {

    }

}

extension EventVC {
    
    @IBAction func starredButtonPressed(_ sender: UIButton) {
        starredButton.starredButtonPressedFor(currentEvent)
    }
    
}
