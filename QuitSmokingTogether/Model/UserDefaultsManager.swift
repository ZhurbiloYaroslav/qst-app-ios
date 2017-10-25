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
    
    var firstParagraphInText: String {
        return defaults.object(forKey: "firstParagraphInText") as? String ?? "Start to reading"
    }
}

extension UserDefaultsManager {

    func saveInfoFor(_ user: User?) {
        guard let userID = user?.uid else { return }
        guard let userEmail = user?.email else { return }
        
        self.keychainManager.set(userID, forKey: "currentUserID")
        self.keychainManager.set(userEmail, forKey: "currentUserEmail")
        
        self.currentUserEmail = userEmail
        self.currentUserLoggedIn = true
        
        if let userName = user?.displayName {
            self.currentUserName = userName
        }
        print("---id-keychain", self.keychainManager.get("currentUserID")!)
        print("---email-keychain", self.keychainManager.get("currentUserEmail")!)
        print("---email-userDef", self.currentUserEmail)
        print("---logIin-userDef", self.currentUserLoggedIn)
    }
    
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
    
    var currentUserEmail: String {
        
        get {
            return defaults.object(forKey: "currentUserEmail") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "currentUserEmail")
            defaults.synchronize()
        }
    }
}
