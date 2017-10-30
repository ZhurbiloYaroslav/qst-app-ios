//
//  UserDefaultsManager.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 23.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import CoreData
import Firebase
import FirebaseAuth
import FacebookLogin
import FacebookCore
import KeychainSwift

class UserDefaultsManager {
    
    private let keychainManager = KeychainSwift()
    
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
}

extension UserDefaultsManager {
    
    public enum Provider: String {
        case Firebase = "Firebase"
        case Facebook = "Facebook"
    }

    func saveInfoFor(_ user: User?, andProvider provider: Provider) {
        guard let userID = user?.uid else { return }
        
        saveUserID(userID, andProvider: provider)
        
        if let userEmail = user?.email {
            self.keychainManager.set(userEmail, forKey: "currentUserEmail")
            self.currentUserEmail = userEmail
        } else {
            self.keychainManager.set("Anonymous", forKey: "currentUserEmail")
            self.currentUserEmail = "Anonymous"
        }
        
        if let userName = user?.displayName {
            self.currentUserName = userName
        }
    }
    
    func saveInfoWith(_ token: AccessToken, andProvider provider: Provider) {
        guard let userID = token.userId else { return }
        
        saveUserID(userID, andProvider: provider)
        
        self.keychainManager.set(token.authenticationToken, forKey: "currentUserAuthenticationToken")
        self.currentUserAuthenticationToken = token.authenticationToken
        
    }
    
    func saveUserID(_ userID: String, andProvider provider: Provider) {
        self.keychainManager.set(userID, forKey: "currentUserID")
        self.keychainManager.set(provider.rawValue, forKey: "currentUserProvider")
        self.currentUserProvider = provider.rawValue
        self.currentUserLoggedIn = true
    }
}

extension UserDefaultsManager {
    
    var currentUserLoggedIn: Bool {
        
        get {
            return defaults.object(forKey: "currentUserLoggedIn") as? Bool ?? false
        }
        set {
            defaults.set(newValue, forKey: "currentUserLoggedIn")
            defaults.synchronize()
        }
    }
    
    var currentUserName: String {
        
        get {
            return defaults.object(forKey: "currentUserName") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "currentUserName")
            defaults.synchronize()
        }
    }
    
    var currentUserAuthenticationToken: String {
        
        get {
            return defaults.object(forKey: "currentUserAuthenticationToken") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "currentUserAuthenticationToken")
            defaults.synchronize()
        }
    }
    
    var currentUserEmail: String {
        
        get {
            return defaults.object(forKey: "currentUserEmail") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "currentUserEmail")
            defaults.synchronize()
        }
    }
    
    var currentUserProvider: String {
        
        get {
            return defaults.object(forKey: "currentUserProvider") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "currentUserProvider")
            defaults.synchronize()
        }
    }
    
    var firstParagraphInText: String {
        return defaults.object(forKey: "firstParagraphInText") as? String ?? "Start to reading"
    }
}
