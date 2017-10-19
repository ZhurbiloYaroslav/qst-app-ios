//
//  AlertVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 10.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class AlertVC: UIViewController {
    
    @IBOutlet weak var adviceLabel: UILabel!
    var advices: Advices!

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeVariables()
    }
    
    func initializeVariables() {
        self.advices = Advices()
    }
    
    @IBAction func nextAdviceButtonPressed(_ sender: UIButton) {
        adviceLabel.text = advices.getNextAdvice()
        
    }
    
}
