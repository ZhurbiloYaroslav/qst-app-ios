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
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    private var activeTextField = UITextField()
    private var fbLoginSuccess = false
    private let userDefaultsManager = UserDefaultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDelegates()
        
        hideKeyboardWhenTappedAround()
        registerForKeyboardNotifications()
        
    }
    
    func initializeDelegates() {
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        performSegueIfLoggedInFacebook()
        moveToMainViewIfLoggedIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func performSegueIfLoggedInFacebook() {
        if (AccessToken.current?.authenticationToken != nil && fbLoginSuccess == true) {
            self.performSegue(withIdentifier: "LoggedInFromLogin", sender: nil)
            fbLoginSuccess = false
        }
    }
    
    func moveToMainViewIfLoggedIn() {
        if CurrentUser.isLoggedIn {
            self.performSegue(withIdentifier: "LoggedInFromLogin", sender: nil)
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        FirebaseAuthManager().signIn(withEmail: emailField.text!, password: passwordField.text!) {
            self.performSegue(withIdentifier: "LoggedInFromLogin", sender: nil)
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SignUpFromLogin", sender: nil)
    }
    
    @IBAction func facebookLoginButtonPressed(_ sender: Any) {
        LoginManager().logIn(readPermissions: [.publicProfile, .email], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error.localizedDescription)
            case .cancelled:
                print("canceled")
            case .success( _, _, let accessToken):
                CurrentUser.saveInfoWith(accessToken, andProvider: .Facebook)
                self.getFBUserInfo()
            }
        }
    }
    
    func getFBUserInfo() {
        let request = GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
        request.start { (response, result) in
            switch result {
            case .success(let value):
                print(value.dictionaryValue)
                if let currentUserEmail = value.dictionaryValue?["email"] as? String {
                    CurrentUser.email = currentUserEmail
                    print("---email:", currentUserEmail)
                }
                if let currentUserID = value.dictionaryValue?["id"] as? String {
                    CurrentUser.id = currentUserID
                    print("---id:", currentUserID)
                }
                if let currentUserName = value.dictionaryValue?["name"] as? String {
                    CurrentUser.name = currentUserName
                    print("---name:", currentUserName)
                }
                self.fbLoginSuccess = true
                self.view.setNeedsDisplay()
                
            case .failed(let error):
                print(error)
            }
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        FirebaseAuthManager().signInAnonymously() {
            self.performSegue(withIdentifier: "SkipButtonPressedInLogin", sender: nil)
        }
        
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {}
    
    deinit {
        removeKeyboardNotifications()
    }
    
}

// Methods, that helps hide Keyboard
extension LoginVC: UITextFieldDelegate {
    // Tutorial Move textfield up when Keyboard appears https://www.youtube.com/watch?v=AiYCStoj0lc
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
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
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        guard let keyboardFrameSize = (userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        let keyboardY = self.view.frame.size.height - keyboardFrameSize.height
        let editingTextFieldY = activeTextField.convert(activeTextField.bounds.origin, to: nil).y
        
        if editingTextFieldY > keyboardY - 90 {
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
                self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY - (keyboardY - 90)),
                                         width: self.view.bounds.width, height: self.view.bounds.height)
            }, completion: nil)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
}

