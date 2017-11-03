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
import Validator

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
//        moveToMainViewIfLoggedIn()
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
        if fieldsAreValidated() {
            FirebaseAuthManager().signIn(withEmail: emailField.text!, password: passwordField.text!) {
                self.performSegue(withIdentifier: "LoggedInFromLogin", sender: nil)
            }
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
                CurrentUser.saveInfoWith(accessToken, andProvider: .authFacebook)
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
                }
                if let currentUserID = value.dictionaryValue?["id"] as? String {
                    CurrentUser.id = currentUserID
                }
                if let currentUserName = value.dictionaryValue?["name"] as? String {
                    CurrentUser.name = currentUserName
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

// Validation
extension LoginVC {
    
    func fieldsAreValidated() -> Bool {
        
        var validationErrors: [String] = [String]()
        
        if isEmailValid(emailField.text) == false || isEmpty(emailField.text) == true {
            validationErrors.append(ValidationErrors.emailInvalid.message)
        }
        if isPasswordValid(passwordField.text) == false || isEmpty(passwordField.text) == true {
            validationErrors.append(ValidationErrors.passwordInvalid.message)
            validationErrors.append(ValidationErrors.passwordMustBe.message)
        }
        if validationErrors.count > 0 {
            presentAlert(validationErrors)
            return false
        }
        
        return true
    }
    
    func presentAlert(_ arrayWithMessages: [String]) {
        let title = "Some Alert"
        var message = ""
        for index in 0...(arrayWithMessages.count - 1) {
            message += arrayWithMessages[index]
            message += (index < (arrayWithMessages.count - 1)) ? "\n" : ""
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func isEmpty(_ value : String?) -> Bool {
        guard let result = value else {
            return true
        }
        return result.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty
    }
    
    func isEmailValid(_ email : String?) -> Bool {
        let fullEmailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let simpleEmailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", simpleEmailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func isPasswordValid(_ password : String?) -> Bool {
        let passwordRegEx = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let simplePassword = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return simplePassword.evaluate(with: password)
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

