//
//  LoginVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 24.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

//MARK: Firebase facebook-login Documentation:
// https://firebase.google.com/docs/auth/ios/facebook-login

import UIKit
import FacebookLogin
import FacebookCore
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var loginFormStackView: UIStackView!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addFacebookLoginButton()
    }
    
    func addFacebookLoginButton() {
        let loginButton = LoginButton(readPermissions: [.publicProfile, .email, .userLocation ])
        loginButton.center = view.center
        loginButton.delegate = self
        
        view.addSubview(loginButton)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        FirebaseAuthManager().signIn(withEmail: loginField.text!, password: passwordField.text!)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        FirebaseAuthManager().createUser(withEmail: loginField.text!, password: passwordField.text!)
    }
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        
    }
    
}

extension LoginVC: LoginButtonDelegate {
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }
        
    //TODO: In your delegate, implement didCompleteWithResult:error:
    func loginButton(loginButton: LoginButton!, didCompleteWithResult result: LoginResult!, error: NSError?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        print("---logged in to Facebook")
        let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
        // ...
    }
}
