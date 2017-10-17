//
//  FAQAnswerVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 17.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class FAQAnswerVC: UIViewController {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    var faqItem: FAQ.Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initializeVariables()
        updateViewWithAnswer()
        
    }
    
    func initializeVariables() {
        self.faqItem = FAQ.Item(section: FAQ.Section(name: ""), question: "", answer: "")
    }
    
    func updateViewWithAnswer() {
        self.questionLabel.text = faqItem.question
        self.answerLabel.text = faqItem.answer
    }
}










