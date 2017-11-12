//
//  CurrentUser.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 31.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FacebookLogin
import FacebookCore
import KeychainSwift

class CurrentUser {
    
    private static let defaults = UserDefaults.standard
    private static let keychainManager = KeychainSwift()
    
    static func getAccountName() -> String {
        if let name = self.name, name != "" {
            return name
        } else if let email = self.email, email != "" {
            return email
        } else {
            return "Anonymous"
        }
    }
    
    static func logOut(completionHandler: @escaping SuccessBehaviour) {
        switch provider {
        case .authFacebook:
            LoginManager().logOut()
            removeUserDataWhenLogOut()
        case .authEmail:
            FirebaseAuthManager().signOut()
            removeUserDataWhenLogOut()
        default:
            removeUserDataWhenLogOut()
        }
        
        FirebaseAuthManager().signInAnonymously {
            completionHandler()
        }
    }
    
    static func removeUserDataWhenLogOut() {
        isLoggedIn = false
        id = nil
        name = nil
        email = nil
        authToken = ""
        provider = .authCustom
    }
}

extension CurrentUser {
    
    static func saveInfoFor(_ user: User?, andProvider provider: Provider) {
        guard let userID = user?.uid else { return }

        saveUserID(userID, andProvider: provider)
        self.email = user?.email
        self.name = user?.displayName
        self.isLoggedIn = true
    }
    
    static func saveInfoWith(_ token: AccessToken, andProvider provider: Provider) {
        guard let userID = token.userId else { return }
        
        saveUserID(userID, andProvider: provider)
        
        self.authToken = token.authenticationToken
        self.isLoggedIn = true
    }
    
    static func saveUserID(_ userID: String, andProvider provider: Provider) {
        self.id = userID
        self.provider = Provider.build(rawValue: provider.rawValue)
        self.isLoggedIn = true
    }
}

extension CurrentUser {
    
    static var isLoggedIn: Bool {
        
        get {
            return defaults.object(forKey: "currentUserIsLoggedIn") as? Bool ?? false
        }
        set {
            defaults.set(newValue, forKey: "currentUserIsLoggedIn")
            defaults.synchronize()
        }
    }
    
    static var id: String? {
        get {
            return self.keychainManager.get("currentUserID") ?? ""
        }
        set {
            guard let currentUserID = newValue else { return }
            self.keychainManager.set(currentUserID, forKey: "currentUserID")
        }
    }
    
    static var name: String? {
        get {
            return defaults.object(forKey: "currentUserName") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "currentUserName")
            defaults.synchronize()
        }
    }
    
    static var email: String? {
        get {
            if let currentUserEmail = defaults.object(forKey: "currentUserEmail") as? String, currentUserEmail != "" {
                return currentUserEmail
            } else if let currentUserEmail = keychainManager.get("currentUserEmail"), currentUserEmail != "" {
                return currentUserEmail
            } else {
                return ""
            }
        }
        set {
            defaults.set(newValue, forKey: "currentUserEmail")
            defaults.synchronize()
            if let currentUserEmail = newValue {
                keychainManager.set(currentUserEmail, forKey: "currentUserEmail")
            } else {
                keychainManager.set("", forKey: "currentUserEmail")
            }
        }
    }
    
    static var authToken: String {
        get {
            return self.keychainManager.get("currentUserAuthenticationToken") ?? ""
        }
        set {
            keychainManager.set(newValue, forKey: "currentUserAuthenticationToken")
        }
    }
    
    static var provider: Provider {
        get {
            if let providerRawValue = keychainManager.get("currentUserProvider"),
                let provider = Provider(rawValue: providerRawValue) {
                return provider
            } else {
                return .authCustom
            }
        }
        set {
            keychainManager.set(provider.rawValue, forKey: "currentUserProvider")
        }
    }
    
    public enum Provider: String {
        case authEmail = "authEmail"
        case authAnonymous = "authAnonymous"
        case authFacebook = "authFacebook"
        case authGoogle = "authGoogle"
        case authCustom = "authCustom"
        
        static func build(rawValue:String?) -> Provider {
            guard let rawValue = rawValue, let provider = Provider(rawValue: rawValue) else {
                return .authCustom
            }
            return  provider
        }
    }
}






