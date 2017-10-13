//
//  NavBarVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 12.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class NavBarVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        giveShadowToView()
        
    }
    
    func giveShadowToView() {
        navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationBar.layer.shadowRadius = 2.0
        navigationBar.layer.shadowOpacity = 0.50
        navigationBar.layer.masksToBounds = false
        
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }

}
