//
//  AppPurchase.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 13.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class AppPurchase {
    
    private var isPRO: Bool {
        return true
        //return UserDefaultsManager().isProVersion
    }
    
    public func doWeShowAdvert() -> Bool {
        if isPRO {
            return false
        } else {
            return true
        }
    }
    
}
