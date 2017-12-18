//
//  Validator.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 06.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class Validator {
    
    static func isEmpty(_ value: String?) -> Bool {
        guard let result = value else {
            return true
        }
        return result.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty
    }
    
    static func isNameValid(_ name: String?) -> Bool {
        let simpleNameRegEx = "\\A\\w{7,18}\\z"
        // or "^[0-9a-zA-Z\\_]{7,18}$"
        // or ^[a-zA-Z\s]+$
        // or ^[a-zA-Z][a-zA-Z\\s]+$
        // let userNameRegEx2 = "\\A\\w{7,18}\\z"
        // let userNameRegEx = "^[0-9a-zA-Z\\_]{6,18}$"
        
        let simpleName = NSPredicate(format: "SELF MATCHES %@", simpleNameRegEx)
        return simpleName.evaluate(with: name)
    }
    
    static func isEmailValid(_ email: String?) -> Bool {
        let simpleEmailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", simpleEmailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func isPasswordValid(_ password: String?) -> Bool {
        let simplePasswordRegEx = "(?=.*[A-Za-z0-9]).{6,}"
        
        let simplePassword = NSPredicate(format: "SELF MATCHES %@", simplePasswordRegEx)
        return simplePassword.evaluate(with: password)
    }
    
    static func isPhoneValid(_ phoneString: String?) -> Bool {
        let phonePatternRegEx = "(?:\\d{2}\\D*){0,2}\\d{4,5}\\D*\\d{4}"
        
        let phonePattern = NSPredicate(format: "SELF MATCHES %@", phonePatternRegEx)
        return phonePattern.evaluate(with: phoneString)
    }
}

//EXTRA CODE
// let phonePattern = "(?:(?:\\+\\d{2}\\h*)?(?:\\(\\d{2}\\)|\\d{2}))?\\h*(\\d{4,5}‌​-?\\d{4})"
// let passwordRegEx = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"

