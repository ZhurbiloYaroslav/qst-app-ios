//
//  Validator.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 06.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class Validator {
    
    static func isEmpty(_ value : String?) -> Bool {
        guard let result = value else {
            return true
        }
        return result.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty
    }
    
    static func isEmailValid(_ email : String?) -> Bool {
        let simpleEmailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", simpleEmailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func isPasswordValid(_ password : String?) -> Bool {
        let simplePasswordRegEx = "(?=.*[A-Za-z0-9]).{6,}"
        
        let simplePassword = NSPredicate(format: "SELF MATCHES %@", simplePasswordRegEx)
        return simplePassword.evaluate(with: password)
    }
}

//CODE TO DELETE
//        let passwordRegEx = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
//        let fullEmailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
