//
//  ReaderVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 12.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class ReaderVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func goOutFromReader(_ sender: UIBarButtonItem) {
        tabBarController?.selectedIndex = 0
    }
    
}
