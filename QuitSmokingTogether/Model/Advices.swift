//
//  Advices.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 18.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import CSV

class Advices {
    
    private let defaults = UserDefaults.standard
    
    var items: [[String: Any]] = []
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
        guard let adviceTitle = items[currentAdviceIndex]["Title"] as? String else {
            return ""
        }
        return adviceTitle
    }
    var currentAdviceMessage: String {
        guard let adviceMessage = items[currentAdviceIndex]["Advice"] as? String else {
            return ""
        }
        return adviceMessage
    }
    
    init() {
        parseAdvicesPlist()
        //        parseAdvicesCsv()
    }
    
    var numberOfAdvices: Int {
        return items.count
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
            items.append(adviceDict)
        }
        
    }
    
    //    func parseAdvicesCsv() {
    //        if let path = Bundle.main.path(forResource: "Advices", ofType: "csv") {
    //            do {
    //                let stream = InputStream(fileAtPath: path)!
    //                let csv = try! CSVReader(stream: stream, hasHeaderRow: true)
    //                while csv.next() != nil {
    //                    createItemAndCategoryFromParsedRow(csv)
    //                }
    //            } catch {
    //                print(error.localizedDescription)
    //            }
    //        }
    //    }
    
    //    func createItemAndCategoryFromParsedRow(_ csv: CSVReader) {
    //        guard let advice = csv["Advice"] else { return }
    //        items.append(advice)
    //    }
}
