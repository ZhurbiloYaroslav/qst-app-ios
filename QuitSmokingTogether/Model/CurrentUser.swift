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
    
    static func logOut(completionHandler: @escaping SuccessBehaviour) {
        switch provider {
        case .authFacebook:
            LoginManager().logOut()
            removeUserDataWhenLogOut()
        case .authEmail:
            FirebaseAuthManager().signOut()
            removeUserDataWhenLogOut()
        case .authGoogle:
            FirebaseAuthManager().signOut()
            removeUserDataWhenLogOut()
        case .authAnonymous:
            FirebaseAuthManager().signOut()
            removeUserDataWhenLogOut()
        default:
            removeUserDataWhenLogOut()
        }
        completionHandler()
    }
    
    static func removeUserDataWhenLogOut() {
        
        isLoggedIn = false
        
        name = ""
        firstName = ""
        lastName = ""
        email = ""
        phone = ""
        authToken = ""
        id = ""
        provider = .noProvider
    }
}

extension CurrentUser {
    
    static func saveInfoFor(_ dataResult: AuthDataResult?, andProvider provider: Provider, andName username: String? = nil) {
        guard let user = dataResult?.user else { return }

        saveUserID(user.providerID, andProvider: provider)
        if let email = user.email {
            self.email = email
        }
        if let username = username {
            self.name = username
        } else if let displayName = user.displayName {
            self.name = displayName
        } else {
            self.name = "Anonymous"
        }
        
        self.isLoggedIn = true
        
        FirebaseManager().updateUserInfoInFirebase()
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
    
    static var accountName: String {
        if fullName != "" {
            return fullName
        } else if email != "" {
            return email
        } else {
            return Constants.DefaultText.ifFullNameIsEmpty
        }
    }
    
    static var isLoggedIn: Bool {
        
        get {
            return defaults.object(forKey: "currentUserIsLoggedIn") as? Bool ?? false
        }
        set {
            defaults.set(newValue, forKey: "currentUserIsLoggedIn")
            defaults.synchronize()
        }
    }
    
    static var id: String {
        get {
            return self.keychainManager.get("currentUserID") ?? ""
        }
        set {
            self.keychainManager.set(newValue, forKey: "currentUserID")
        }
    }
    
    static var name: String {
        get {
            return defaults.object(forKey: "currentUserName") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "currentUserName")
            defaults.synchronize()
        }
    }
    
    static var fullName: String {
        var fullName = ""
        if firstName != "" {
            fullName = firstName
        }
        if firstName != "" && lastName != "" {
            fullName = fullName + " "
        }
        if lastName != "" {
            fullName = fullName + lastName
        }
        return fullName
    }
    
    static var firstName: String {
        get {
            if let firstName = defaults.object(forKey: "currentUserFirstName") as? String, firstName != "" {
                return firstName
            } else {
                return Constants.DefaultValue.forEmptyFirstName
            }
        }
        set {
            FirebaseManager().updateInFirebaseUserValue(newValue, withKey: .FirstName)
            defaults.set(newValue, forKey: "currentUserFirstName")
            defaults.synchronize()
        }
    }
    
    static var lastName: String {
        get {
            if let lastName = defaults.object(forKey: "currentUserLastName") as? String, lastName != "" {
                return lastName
            } else {
                return Constants.DefaultValue.forEmptyLastName
            }
        }
        set {
            FirebaseManager().updateInFirebaseUserValue(newValue, withKey: .LastName)
            defaults.set(newValue, forKey: "currentUserLastName")
            defaults.synchronize()
        }
    }
    
    static var email: String {
        get {
            if let currentUserEmail = keychainManager.get("currentUserEmail"), currentUserEmail != "" {
                return currentUserEmail
            } else {
                return Constants.DefaultValue.forEmptyEmail
            }
        }
        set {
            FirebaseManager().updateInFirebaseUserValue(newValue, withKey: .Email)
            keychainManager.set(newValue, forKey: "currentUserEmail")
        }
    }
    
    static var phone: String {
        get {
            if let currentUserPhone = keychainManager.get("currentUserPhone"), currentUserPhone != "" {
                return currentUserPhone
            } else {
                return Constants.DefaultValue.forEmptyPhone
            }
        }
        set {
            FirebaseManager().updateInFirebaseUserValue(newValue, withKey: .Phone)
            keychainManager.set(newValue, forKey: "currentUserPhone")
        }
    }
    
    static var didUserShareThisApp: Bool {
        
        get {
            return defaults.object(forKey: "didUserShareThisApp") as? Bool ?? false
        }
        set {
            defaults.set(newValue, forKey: "didUserShareThisApp")
            defaults.synchronize()
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
                return .noProvider
            }
        }
        set {
            keychainManager.set(provider.rawValue, forKey: "currentUserProvider")
        }
    }
    
    static var eventsInfo: [String: Event] {
        return ["1": Event()]
    }
    
    public enum Provider: String {
        case authEmail = "authEmail"
        case authAnonymous = "authAnonymous"
        case authFacebook = "authFacebook"
        case authGoogle = "authGoogle"
        case noProvider = "noProvider"
        
        static func build(rawValue:String?) -> Provider {
            guard let rawValue = rawValue, let provider = Provider(rawValue: rawValue) else {
                return .noProvider
            }
            return  provider
        }
    }
}






