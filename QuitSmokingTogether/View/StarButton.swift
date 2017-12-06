//
//  StarButton.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 05.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class StarButton: UIButton {

    override func awakeFromNib() {
        
        setUpTheStarButton()
        
    }
    
    func setUpTheStarButton() {
        self.imageView?.image = UIImage(named: "icon-star")?.withRenderingMode(.alwaysTemplate)
        self.tintColor = Constants.Color.starInactive
    }
    
    func makeButtonActiveIfActive(_ event: Event) {
        if event.status == .Starred {
            self.tintColor = Constants.Color.starActive
        }
    }
    
    func starredButtonPressedFor(_ event: Event) {
        if event.status == .Starred {
            event.status = .Read
            self.tintColor = Constants.Color.starInactive
        } else {
            event.status = .Starred
            self.tintColor = Constants.Color.starActive
        }
    }

}
