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
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var activeTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDelegates()
        
        self.hideKeyboardWhenTappedAround()
        registerForKeyboardNotifications()
        
    }
    
    func initializeDelegates() {
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if fieldsAreValidated() {
            FirebaseAuthManager().createUser(withEmail: emailField.text!, password: passwordField.text!) {
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





