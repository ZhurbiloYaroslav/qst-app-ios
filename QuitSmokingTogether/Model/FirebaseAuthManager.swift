//
//  FirebaseAuthManager.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 24.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//
//TODO: Handle Firebase iOS Auth Errors:
// https://firebase.google.com/docs/auth/ios/errors

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import KeychainSwift

class FirebaseAuthManager {
    
    public var handle: AuthStateDidChangeListenerHandle!
    
    private let keychainManager = KeychainSwift()
    private let userDefaultsManager = UserDefaultsManager()
    
    init() {
        //TODO: some code here
    }
    
    public func createUser(withEmail email: String, password: String, completionHandler: @escaping SuccessBehaviour) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                CurrentUser.saveInfoFor(user, andProvider: .authEmail)
                completionHandler()
            } else {
                print("---createUser Fail", error!.localizedDescription)
            }
        }
    }
    
    public func signIn(withEmail email: String, password: String, completionHandler: @escaping SuccessBehaviour) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                CurrentUser.saveInfoFor(user, andProvider: .authEmail)
                
                Auth.auth().currentUser?.getIDToken() { token, error in
                    if error == nil, let token = token {
                        CurrentUser.authToken = token
                        completionHandler()
                    }
                }
                
            } else {
                //
            }
        }
    }
    
    public func signInAnonymously(completionHandler: @escaping SuccessBehaviour) {
        Auth.auth().signInAnonymously() { (user, error) in
            if error == nil {
                CurrentUser.saveInfoFor(user, andProvider: .authAnonymous)
                
                Auth.auth().currentUser?.getIDToken() { token, error in
                    if error == nil, let token = token {
                        CurrentUser.authToken = token
                        completionHandler()
                    }
                }
                
            } else {
                //
            }
        }
    }
    
    //TODO: attach the listener in the view controller's viewWillAppear method:
    public func addStateDidChangeListener() {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
    }
    
    //TODO: detach the listener in the view controller's viewWillDisappear method
    public func removeStateDidChangeListener() {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    public func authenticateUsingFirebaseCredential(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
//            if let error = error {
//                // ...
//                return
//            }
            // User is signed in
            // ...
        }
    }
    
    public func getAnonymousUsersAccountDataFor(_ user: User?) {
//                if let user = user {
//                    let isAnonymous = user.isAnonymous  // true
//                    let uid = user.uid
//                    print("---userinfo", uid, "---", user.email)
//                }
    }
    
    public func getUserInfo(user: User?) {
        //        if let user = user {
        //            // The user's ID, unique to the Firebase project.
        //            // Do NOT use this value to authenticate with your backend server,
        //            // if you have one. Use getTokenWithCompletion:completion: instead.
        //            let uid = user.uid
        //            let email = user.email
        //            let photoURL = user.photoURL
        //            // ...
        //        }
    }
    
    public func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    //TODO: Convert an anonymous account to a permanent account
    // https://firebase.google.com/docs/auth/ios/anonymous-auth
}
