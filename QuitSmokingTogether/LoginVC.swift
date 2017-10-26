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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewInScrollView: UIView!
    @IBOutlet weak var loginFormStackView: UIStackView!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDelegates()
        
        self.hideKeyboardWhenTappedAround()
        registerForKeyboardNotifications()
        
    }
    
    func initializeDelegates() {
        loginField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func facebookLoginButtonPressed(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
            }
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        FirebaseAuthManager().signIn(withEmail: loginField.text!, password: passwordField.text!)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        FirebaseAuthManager().createUser(withEmail: loginField.text!, password: passwordField.text!)
    }
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
}

// Textfield Delegate
extension LoginVC: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        return true
    }
    
}

// Methods, that helps hide Keyboard
extension LoginVC {
    
    //TODO: Hide keyboard
    func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    func removeKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        guard let keyboardFrameSize = (userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrameSize.height)
    }
    
    @objc func keyboardWillHide() {
        scrollView.contentOffset = CGPoint.zero
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
        print("--Token", AccessToken.current?.authenticationToken)
    }
}
