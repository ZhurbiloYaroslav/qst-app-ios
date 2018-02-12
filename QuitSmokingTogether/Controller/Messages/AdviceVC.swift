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
    @IBOutlet weak var messageContainerView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backMessageView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var adviceTitleLabel: UILabel!
    @IBOutlet weak var adviceMessageLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var messagesManager: MessagesManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUIStyles()
        initializeVariables()
    }
    
    func setUIStyles() {
        messageContainerView.setRadius(20, withWidth: 1, andColor: UIColor.clear)
        backMessageView.setRadius(20, withWidth: 1, andColor: UIColor.clear)
        contentView.setRadius(20, withWidth: 1, andColor: UIColor.clear)
    }
    
    func initializeVariables() {
        if let messagesManager = messagesManager {
            let randomMessage = messagesManager.getCurrentMessage()
            characterImage.image = randomMessage.image
            adviceTitleLabel.text = randomMessage.title
            adviceMessageLabel.text = randomMessage.text
            
            backButton.isHidden = messagesManager.doesWeHidePreviousButton()
        }
    }
    
    @IBAction func backAdviceButtonPressed(_ sender: UIButton) {
        if let messagesManager = messagesManager {
            let previousMessage = messagesManager.getPreviousMessage()
            adviceMessageLabel.text = previousMessage.text
            adviceTitleLabel.text = previousMessage.title
            characterImage.image = previousMessage.image
            scrollView.scrollToTop(animated: false)
        }
    }
    
    @IBAction func nextAdviceButtonPressed(_ sender: UIButton) {
        if let messagesManager = messagesManager {
            if let nextMessage = messagesManager.getNextMessage() {
                
                adviceMessageLabel.text = nextMessage.text
                adviceTitleLabel.text = nextMessage.title
                characterImage.image = nextMessage.image
                scrollView.scrollToTop(animated: false)
            }
            
            if messagesManager.thisIsTheLastMessage() {

                messagesManager.resetCurrentIndex()
                nextButton.setTitle("Begin", for: .normal)
                nextButton.removeTarget(nil, action: #selector(nextAdviceButtonPressed(_:)), for: .allEvents)
                nextButton.addTarget(self, action: #selector(finishGreetings(_:)), for: .touchUpInside)
            }
        }
        
    }
    
    @objc func finishGreetings(_ sender: UIButton) {
        
        if let loginVC = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            self.present(loginVC, animated: true, completion: nil)
        }
        
    }
    
}
