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
    
    func addCurrentUserToFirebaseDatabase() {
        self.ref.child("users").child(CurrentUser.id).setValue(["username": CurrentUser.name])
    }
}
