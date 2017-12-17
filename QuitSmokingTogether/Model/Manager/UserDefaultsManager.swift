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
        return defaults.object(forKey: "chapterInText") as? String ?? "Introduction"
    }
    
    var firstParagraphInText: String {
        return defaults.object(forKey: "firstParagraphInText") as? String ?? "Dear friend! I hope reading these lines doesn't make you yawn and you took this book from your shelf not out of desperation to find something interesting to read. If it has somehow made its way to your library, I believe it's either you are a smoker or a member of your family, who did not bother to take off the shelf this manual that may have been gathering dust there for months. Smokers always tend to buy such publications; many even read a few chapters, but lose interest towards the end."
    }
}
