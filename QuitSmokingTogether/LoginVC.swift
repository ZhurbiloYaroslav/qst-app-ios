//
//  LoginVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 24.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import FacebookLogin

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addFacebookLoginButton()
    }
    
    func addFacebookLoginButton() {
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
    }

}
