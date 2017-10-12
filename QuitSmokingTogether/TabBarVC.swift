//
//  TabBarVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 12.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let arrayOfImageNameForSelectedState = ["icon_menu","icon_book","icon_settings"]
        let arrayOfImageNameForUnselectedState = ["icon_menu","icon_book","icon_settings"]
        
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                // let imageNameForSelectedState   = arrayOfImageNameForSelectedState[i]
                let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]
                
                // self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
            }
        }

        let selectedColor   = UIColor.red
        let unselectedColor = UIColor.white
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedColor], for: .selected)
    }

}
