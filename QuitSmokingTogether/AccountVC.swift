//
//  AccountVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 31.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FirebaseAuth

class AccountVC: UIViewController {

    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var accountEmailLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillLabelsWithValues()
    }
    
    func fillLabelsWithValues() {
        accountNameLabel.text = CurrentUser.name
        accountEmailLabel.text = CurrentUser.email
        print("---authToken", CurrentUser.authToken)
        print("---id", CurrentUser.id)
        print("---provider", CurrentUser.provider.rawValue)
        logOutButton.setTitle("Log Out from \(CurrentUser.provider.rawValue)", for: .normal)
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        CurrentUser.logOut() {
            self.fillLabelsWithValues()
        }
    }
    
}
