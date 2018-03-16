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
        
        giveShadowToView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        localizeUI()
    }
    
    func localizeUI() {
        guard let items = tabBar.items else { return }
        
        items[0].title = "tabbar_main".localized()
        items[1].title = "tabbar_events".localized()
        items[2].title = "tabbar_read".localized()
        items[3].title = "tabbar_donate".localized()
        items[4].title = "tabbar_options".localized()
    }
    
    func giveShadowToView() {
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        tabBar.layer.shadowRadius = 4.0
        tabBar.layer.shadowOpacity = 1.0
        tabBar.layer.masksToBounds = false
    }
    
    func changeColorOfTabBarItems() {
        
        let selectedColor   = Constants.Color.green
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedColor], for: .selected)
    }

}
