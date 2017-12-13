//
//  OnlineVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 23.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class OnlineVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func callPhoneButtonPressed(_ sender: UIButton) {
        Browser.openURLWith(.Call_Phone)
    }
    
    @IBAction func callViberButtonPressed(_ sender: UIButton) {
        Browser.openURLWith(.Call_Viber)
    }
    
    @IBAction func callWhatsAppButtonPressed(_ sender: UIButton) {
        Browser.openURLWith(.Call_WhatsApp)
    }
    
    @IBAction func callSkypeButtonPressed(_ sender: UIButton) {
        Browser.openURLWith(.Call_Skype)
    }
    
    @IBAction func makeEmailButtonPressed(_ sender: UIButton) {
        Browser.openURLWith(.Mail_Alexeykovalua)
    }
    
}
