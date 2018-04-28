//
//  RegisterVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 29.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var loginFormStackView: UIStackView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    var activeTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDelegates()
        
        self.hideKeyboardWhenTappedAround()
        registerForKeyboardNotifications()
        localizeUI()
    }
    
    func initializeDelegates() {
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    func localizeUI() {
        registerButton.setTitle("button_register".localized(), for: .normal)
        loginButton.setTitle("button_have_account_login".localized(), for: .normal)
        continueButton.setTitle("button_continue_without_login".localized(), for: .normal)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if fieldsAreValidated() {
            FirebaseAuthManager().createUser(withEmail: emailField.text!,
                                             password: passwordField.text!,
                                             name: nameField.text!) {
                                                
                self.performSegue(withIdentifier: "RegisteredFromRegister", sender: nil)
            }
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        FirebaseAuthManager().signInAnonymously() {
            self.performSegue(withIdentifier: "SkipButtonPressedInRegister", sender: nil)
        }
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
}

// Validation
extension RegisterVC {
    
    func fieldsAreValidated() -> Bool {
        
        var validationErrors: [String] = [String]()
        
        /* TODO: WBhPMw ) - Resolve issue with multiple words in User Name
        if Validator.isNameValid(nameField.text) == false || Validator.isEmpty(nameField.text) == true {
            validationErrors.append(ValidationErrors.userNameInvalid.message)
            validationErrors.append(ValidationErrors.userNameMustBe.message)
        }
        */
        
        if Validator.isEmailValid(emailField.text) == false || Validator.isEmpty(emailField.text) == true {
            validationErrors.append(ValidationErrors.emailInvalid.message)
        }
        
        if Validator.isPasswordValid(passwordField.text) == false || Validator.isEmpty(passwordField.text) == true {
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
        let title = "alert_register_title".localized()
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
extension RegisterVC: UITextFieldDelegate {
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





