//
//  AdviceVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 10.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class AdviceVC: UIViewController {
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var adviceTitleLabel: UILabel!
    @IBOutlet weak var adviceMessageLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var advices: AdvicesManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeVariables()
    }
    
    func initializeVariables() {
        self.advices = AdvicesManager()
        characterImage.image = advices.currentCharacterImage
        adviceTitleLabel.text = advices.currentAdviceTitle
        adviceMessageLabel.text = advices.currentAdviceMessage
    }
    
    @IBAction func backAdviceButtonPressed(_ sender: UIButton) {
        adviceMessageLabel.text = advices.getPreviousAdvice()
        adviceTitleLabel.text = advices.currentAdviceTitle
        characterImage.image = advices.currentCharacterImage
        scrollView.scrollToTop(animated: false)
    }
    
    @IBAction func nextAdviceButtonPressed(_ sender: UIButton) {
        adviceMessageLabel.text = advices.getNextAdvice()
        adviceTitleLabel.text = advices.currentAdviceTitle
        characterImage.image = advices.currentCharacterImage
        scrollView.scrollToTop(animated: false)
    }
    
}
