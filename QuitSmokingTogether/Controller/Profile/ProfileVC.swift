//
//  ProfileVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 25.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FirebaseAuth

class ProfileVC: UITableViewController {
    
    @IBOutlet weak var firstNamePlaceholder: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNamePlaceholder: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var emailPlaceholder: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var passwordPlaceholder: UILabel!
    
    @IBOutlet weak var phonePlaceholder: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    
    @IBOutlet weak var logOutLabel: UILabel!
    
    var currentAlertVC: UIAlertController!
    var textFieldTypeInCurrentAlertVC: ProfileField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillLabelsWithValues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        localizeUI()
    }
    
    func fillLabelsWithValues() {
        firstNameLabel.text = CurrentUser.firstName
        lastNameLabel.text = CurrentUser.lastName
        userEmailLabel.text = CurrentUser.email
        userPhoneLabel.text = CurrentUser.phone
    }
    
    func localizeUI() {
        navigationItem.title = "profile_screen_title".localized()
        firstNamePlaceholder.text = "placeholder_firstname".localized()
        lastNamePlaceholder.text = "placeholder_lastname".localized()
        emailPlaceholder.text = "placeholder_email".localized()
        passwordPlaceholder.text = "placeholder_password".localized()
        phonePlaceholder.text = "placeholder_phone".localized()
        logOutLabel.text = "log_out".localized()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0,0]:
            showAlertToChange(field: .FirstName)
        case [0,1]:
            showAlertToChange(field: .LastName)
        case [1,0]:
            showAlertToChange(field: .Email)
        case [1,1]:
            showAlertToChange(field: .Password)
        case [2,0]:
            showAlertToChange(field: .Phone)
        case [3,0]:
            showAlertToChange(field: .LogOut)
            break
        default:
            break
        }
    }
    
    func showAlertToChange(field: ProfileField) {
        
        let alertTitle = "profile_change_title".localized()
        let alertMessage = "profile_change_message".localized()
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let alertActionCancel = UIAlertAction(title: "button_cancel".localized(), style: .cancel, handler: nil)
        let alertActionOk = UIAlertAction(title: "button_ok".localized(), style: .default) { [weak alertController] (_) in
            self.saveUserInfoFromAlertTextField(alertController, field: field)
        }
        
        alertController.addAction(alertActionCancel)
        
        switch field {
        case .FirstName:
            alertController.title = "change_first_name".localized()
            alertController.message = "" // "\(alertMessage): First name"
            makeFirstTextFieldForAlertController(alertVC: alertController, field: .FirstName)
            alertController.addAction(alertActionOk)
        case .LastName:
            alertController.title = "change_last_name".localized()
            alertController.message = "" // "\(alertMessage): Last name"
            makeFirstTextFieldForAlertController(alertVC: alertController, field: .LastName)
            alertController.addAction(alertActionOk)
        case .Email:
            alertController.title = "change_email".localized()
            alertController.message = "" // "\(alertMessage): Email"
            makeFirstTextFieldForAlertController(alertVC: alertController, field: .Email)
            alertController.addAction(alertActionOk)
        case .Password:
            alertController.title = "change_password".localized()
            alertController.message = "" // "\(alertMessage): Password"
            makeFirstTextFieldForAlertController(alertVC: alertController, field: .Password)
            alertController.addAction(alertActionOk)
        case .Phone:
            alertController.title = "change_phone".localized()
            alertController.message = "" // "\(alertMessage): Phone"
            makeFirstTextFieldForAlertController(alertVC: alertController, field: .Phone)
            alertController.addAction(alertActionOk)
        case .LogOut:
            alertController.title = "log_out".localized()
            alertController.message = "log_out_really_want".localized()
            alertController.addAction(UIAlertAction(title: "log_out".localized(), style: .destructive, handler: { (alertAction) in
                self.logOutFromAccout()
            }))
        }
        
        present(alertController, animated: true)
    }
    
    func saveUserInfoFromAlertTextField(_ alertController: UIAlertController?, field: ProfileField) {
        if let alertFieldText = alertController?.textFields?[0].text {
            switch field {
            case .FirstName:
                CurrentUser.firstName = alertFieldText
            case .LastName:
                CurrentUser.lastName = alertFieldText
            case .Email:
                CurrentUser.email = alertFieldText
            case .Phone:
                CurrentUser.phone = alertFieldText
            default:
                break
            }
        }
        self.fillLabelsWithValues()
        self.tableView.reloadData()
    }
    
    func logOutFromAccout() {
        CurrentUser.logOut() {
            self.fillLabelsWithValues()
            self.performSegue(withIdentifier: "LoggedOutFromProfile", sender: nil)
        }
    }
    
    func makeFirstTextFieldForAlertController(alertVC: UIAlertController, field: ProfileField) {
        
        currentAlertVC = alertVC
        textFieldTypeInCurrentAlertVC = field
        
        alertVC.addTextField { (textField) in
            switch field {
            case .FirstName:
                textField.text = CurrentUser.firstName
                textField.placeholder = "placeholder_firstname".localized()
                textField.autocapitalizationType = UITextAutocapitalizationType.sentences
            case .LastName:
                textField.text = CurrentUser.lastName
                textField.placeholder = "placeholder_lastname".localized()
                textField.autocapitalizationType = UITextAutocapitalizationType.sentences
            case .Email:
                textField.text = CurrentUser.email
                textField.placeholder = "placeholder_email".localized()
                textField.keyboardType = UIKeyboardType.emailAddress
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            case .Password:
                textField.text = ""
                textField.placeholder = "placeholder_password".localized()
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            case .Phone:
                textField.placeholder = "placeholder_phone".localized()
                textField.text = CurrentUser.phone
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            case .LogOut:
                return
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let fieldText = textField.text else { return }
        var newMessage = ""
        var attributes = [ NSAttributedStringKey.foregroundColor : UIColor.black ]
        
        switch textFieldTypeInCurrentAlertVC {
            
        case .Email:
            if Validator.isEmailValid(fieldText) {
                newMessage = "email_is_okay".localized()
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.green ]
            } else {
                newMessage = "email_is_invalid".localized()
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.red ]
            }
            
        case .Password:
            if Validator.isPasswordValid(fieldText) {
                newMessage = "password_is_okay".localized()
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.green ]
            } else {
                newMessage = "password_is_invalid".localized()
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.red ]
            }
            
        case .Phone:
            if Validator.isPhoneValid(fieldText) {
                newMessage = "phone_is_okay".localized()
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.green ]
            } else {
                newMessage = "phone_is_invalid".localized()
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.red ]
            }
            
        default:
            break
        }
        
        let attributedString = NSAttributedString(string: newMessage, attributes: attributes)
        currentAlertVC.setValue(attributedString, forKey: "attributedMessage")
        
    }
    
    enum ProfileField {
        case FirstName
        case LastName
        case Email
        case Password
        case Phone
        case LogOut
    }
    
}
