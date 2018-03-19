//
//  UserDefaultsManager.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 23.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FacebookLogin
import FacebookCore
import KeychainSwift

class UserDefaultsManager {
    
    private let defaults = UserDefaults.standard
    
    private var options: [String: String] {
        get {
            return defaults.object(forKey: "options") as? [String: String] ?? [String: String]()
        }
        set {
            defaults.set(newValue, forKey: "options")
            defaults.synchronize()
        }
    }
    
    var isProVersion: Bool {
        get {
            return (self.options["isProVersion"] == "true") ? true : false
        }
        set {
            self.options["isProVersion"] = String(newValue)
        }
    }
}

extension UserDefaultsManager {
    
    var chapterInText: String {
        return defaults.object(forKey: "chapterInText") as? String ?? "book_chapter_first_title".localized()
    }
    
    var firstParagraphInText: String {
        return defaults.object(forKey: "firstParagraphInText") as? String ?? ""
    }
}
