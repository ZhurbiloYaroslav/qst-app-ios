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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var orLoginWithLabel: UILabel!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    private var activeTextField = UITextField()
    private var fbLoginSuccess = false
    private let userDefaultsManager = UserDefaultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDelegates()
        
        hideKeyboardWhenTappedAround()
        registerForKeyboardNotifications()
        localizeUI()
    }
    
    func initializeDelegates() {
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        performSegueIfLoggedInFacebook()
    }
    
    func localizeUI() {
        
        loginButton.setTitle("button_login".localized(), for: .normal)
        signUpButton.setTitle("button_signup".localized(), for: .normal)
        orLoginWithLabel.text = "or_login_with".localized()
        continueButton.setTitle("button_continue_without_login".localized(), for: .normal)
    }
    
    func performSegueIfLoggedInFacebook() {
        if (AccessToken.current?.authenticationToken == CurrentUser.authToken) {
            self.performSegue(withIdentifier: "LoggedInFromLogin", sender: nil)
            fbLoginSuccess = false
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if fieldsAreValidated() {

            FirebaseAuthManager().signIn(withEmail: emailField.text!, password: passwordField.text!) { error in
                if let errorMessage = error?.localizedDescription {
                    
                    Alert().presentLoginAlertWith(messages: [errorMessage]) { alertController in
                        self.present(alertController, animated: true, completion: nil)
                    }
                } else {
                    self.performSegue(withIdentifier: "LoggedInFromLogin", sender: nil)
                }
                
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
                CurrentUser.authToken = accessToken.authenticationToken
                self.getFBUserInfo()
            }
        }
    }
    
    @IBAction func googleLoginButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func restorePasswordButtonPressed(_ sender: UIButton) {
        
        guard let email = emailField.text else { return }
        
        if Validator.isEmailValid(email) {
            FirebaseAuthManager().restorePasswordFor(email: email, completionHandler: {
                let alertMessages = ["check_email_restore_password".localized()]
                Alert().presentLoginAlertWith(messages: alertMessages, completionHandler: { alertController in
                    self.present(alertController, animated: true, completion: nil)
                })
            })
        } else {
            let alertMessages = [
                "email_is_invalid".localized(),
                "write_correct_email".localized(),
                "email_should_be".localized()
            ]
            Alert().presentLoginAlertWith(messages: alertMessages, completionHandler: { alertController in
                self.present(alertController, animated: true, completion: nil)
            })
        }
        
    }
    
    func getFBUserInfo() {
        let request = GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
        request.start { (response, result) in
            switch result {
            case .success(let value):

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
        
        if Validator.isEmailValid(emailField.text) == false || Validator.isEmpty(emailField.text) == true {
            validationErrors.append(ValidationErrors.emailInvalid.message)
        }
        if Validator.isPasswordValid(passwordField.text) == false || Validator.isEmpty(passwordField.text) == true {
            validationErrors.append(ValidationErrors.passwordInvalid.message)
            validationErrors.append(ValidationErrors.passwordMustBe.message)
        }
        if validationErrors.count > 0 {
            presentAlertWith(messages: validationErrors)
            return false
        }
        return true
    }
    
    func presentAlertWith(messages arrayWithMessages: [String]) {
        let title = "alert_login_title".localized()
        var message = ""
        for index in 0...(arrayWithMessages.count - 1) {
            message += arrayWithMessages[index]
            message += (index < (arrayWithMessages.count - 1)) ? "\n" : ""
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "button_ok".localized(), style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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

