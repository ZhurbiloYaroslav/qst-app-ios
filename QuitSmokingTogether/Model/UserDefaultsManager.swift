//
//  UserDefaultsManager.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 23.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import CoreData

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
    
    var firstParagraphInText: String {
        return defaults.object(forKey: "firstParagraphInText") as? String ?? "Start to reading"
    }
}
