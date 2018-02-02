//
//  Advices.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 18.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class AdvicesManager {
    
    private let defaults = UserDefaults.standard
    
    var arrayWithAdvices: [Advice] = [Advice]()
    
    var currentAdviceIndex: Int {
        get {
            return defaults.object(forKey: "currentAdviceIndex") as? Int ?? 0
        }
        set {
            defaults.set(newValue, forKey: "currentAdviceIndex")
            defaults.synchronize()
        }
    }
    
    var currentAdviceTitle: String {
        return arrayWithAdvices[currentAdviceIndex].title
    }
    
    var currentAdviceMessage: String {
        return arrayWithAdvices[currentAdviceIndex].message
    }
    
    var currentCharacterImage: UIImage {
        return arrayWithAdvices[currentAdviceIndex].image
    }
    
    init() {
        parseAdvicesPlist()
    }
    
    var numberOfAdvices: Int {
        return arrayWithAdvices.count
    }
    
    func getRandomAdvice() -> String {
        
        let uIntNumber = UInt32(numberOfAdvices)
        let randomAdviceIndex = Int(arc4random_uniform(uIntNumber))
        currentAdviceIndex = randomAdviceIndex
        
        return currentAdviceMessage
    }
    
    func getPreviousAdvice() -> String {
        
        if currentAdviceIndex == 0 {
            currentAdviceIndex = numberOfAdvices - 1
        } else {
            currentAdviceIndex -= 1
        }
        
        return currentAdviceMessage
    }
    
    func getNextAdvice() -> String {
        
        if currentAdviceIndex == numberOfAdvices - 1 {
            currentAdviceIndex = 0
        } else {
            currentAdviceIndex += 1
        }
        
        return currentAdviceMessage
    }
    
    func parseAdvicesPlist() {
        
        guard let path = Bundle.main.path(forResource: "Advices", ofType: "plist"),
            let arrayWithAdvicesDictionaries = NSArray(contentsOfFile: path) as? [[String: Any]] else {
                return
        }
        
        for adviceDict in arrayWithAdvicesDictionaries {
            let advice = Advice(withDict: adviceDict)
            arrayWithAdvices.append(advice)
        }
        
    }
}
