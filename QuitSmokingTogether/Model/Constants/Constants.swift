//
//  Constants.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 12.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import Foundation

struct Constants {
    
    struct Color {
        //static let col = ColorLiteral (type it)
        static let red = UIColor(red: 208.0/255.0, green: 2.0/255.0, blue: 27.0/255.0, alpha: 1.0)
        static let green = UIColor(red: 94.0/255.0, green: 188.0/255.0, blue: 54.0/255.0, alpha: 1.0)
        static let starActive = UIColor.yellow
        static let starInactive = UIColor.darkGray
    }
    
    struct DefaultText {
        static let ifFullNameIsEmpty = "Anonymous"
        static let ifFirstNameIsEmpty = "There is no phone"
        static let ifLastNameIsEmpty = "There is no phone"
        static let ifEmailIsEmpty = "There is no email"
        static let ifPhoneIsEmpty = "There is no phone"
    }
    
    struct DefaultValue {
        static let forEmptyFirstName = ""
        static let forEmptyLastName = ""
        static let forEmptyEmail = ""
        static let forEmptyPhone = ""
    }
    
    struct AppInfo {
        static var versionAndBuild: String {
            return "\(version) (\(build))"
        }
        static var version: String {
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"]  as? String ?? "Undefined"
        }
        static var build: String {
            return Bundle.main.infoDictionary?["CFBundleVersion"]  as? String ?? "Undefined"
        }
    }
    
    
}
