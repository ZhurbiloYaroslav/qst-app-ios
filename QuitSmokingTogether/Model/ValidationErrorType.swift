//
//  Error.swift
//  Example
//
//  Created by Adam Waite on 29/10/2016.
//  Copyright © 2016 adamjwaite.co.uk. All rights reserved.
//

import Foundation

enum ValidationErrors: String, Error {
    case emailInvalid = "Email address is invalid"
    var message: String { return self.rawValue }
}
