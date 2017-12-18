//
//  FirebaseManager.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 29.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseManager {
    
    var ref: DatabaseReference!
    
    init() {
        configureFirebaseManager()
    }
    
    func configureFirebaseManager() {
        ref = Database.database().reference()
    }
    
    func updateUserInfoInFirebase() {
        let userValues: [String: String] = [
            Path.FirstName.rawValue: CurrentUser.firstName,
            Path.LastName.rawValue: CurrentUser.lastName,
            Path.Phone.rawValue: CurrentUser.phone,
            Path.Email.rawValue: CurrentUser.email
        ]
        self.ref.child(Path.Users.rawValue).child(CurrentUser.id).setValue(userValues)
    }
    
    func updateInFirebaseUserValue(_ value: String, withKey key: Path) {
        self.ref.child(Path.Users.rawValue).child(CurrentUser.id).child(key.rawValue).setValue(value)
    }
    
    func getFromFirebaseUserValueForKey(_ key: Path) -> String? {
        //return self.ref.child(Path.Users.rawValue).child(CurrentUser.id).value(forKey: key.rawValue) as? String ?? nil
        return nil
    }
    
    enum Path: String {
        case Users = "Users"
        case FirstName = "FirstName"
        case LastName = "LastName"
        case Phone = "Phone"
        case Email = "Email"
    }
}
