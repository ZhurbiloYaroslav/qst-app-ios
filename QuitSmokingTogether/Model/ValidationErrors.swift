//
//  ValidationErrors.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 31.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

enum ValidationErrors: String {
    case emailEmpty = "Email address is empty"
    case emailInvalid = "Email address is invalid"
    
    case passwordEmpty = "Password is empty"
    case passwordInvalid = "Password is invalid"
    case passwordMustBe = "\nPassword must be 8 characters including 1 uppercase letter, 1 special character, alphanumeric characters"
    
    var message: String { return self.rawValue }
}
