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
            FirebaseValue.FirstName.rawValue: CurrentUser.firstName,
            FirebaseValue.LastName.rawValue: CurrentUser.lastName,
            FirebaseValue.Phone.rawValue: CurrentUser.phone,
            FirebaseValue.Email.rawValue: CurrentUser.email
        ]
        self.ref.child("users").child(CurrentUser.id).setValue(userValues)
    }
    
    enum FirebaseValue: String {
        case FirstName = "FirstName"
        case LastName = "LastName"
        case Phone = "Phone"
        case Email = "Email"
    }
}
