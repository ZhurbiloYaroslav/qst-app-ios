//
//  StoryboardInitialized.swift
//  UREClub
//
//  Created by Yaroslav Zhurbilo on 30.01.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

protocol FastInitialization {}

extension FastInitialization {
    
    private static func getClassName() -> String {
        return String(describing: self)
    }
    
    public static func storyboardInstance() -> Self? {
        let currentClassName = getClassName()
        let classNameWithoutVC = currentClassName.replacingOccurrences(of: "VC", with: "")
        
        
        guard let storyboard = UIStoryboard(name: String(describing: self), bundle: nil) {
            return nil
        }
        return storyboard.instantiateInitialViewController() as? Self
        
    }
    static func nibInstance() -> Self? {
        let nib = Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)
        return nib?.first as? Self
    }
}
