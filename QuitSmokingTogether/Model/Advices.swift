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
    
    var items: [String] = []
    var currentAdviceIndex: Int {
        get {
            return defaults.object(forKey: "currentAdviceIndex") as? Int ?? 0
        }
        set {
            defaults.set(newValue, forKey: "currentAdviceIndex")
            defaults.synchronize()
        }
    }
    
    init() {
        parseAdvicesCsv()
    }
    
    var numberOfAdvices: Int {
        return items.count
    }
    
    func getRandomAdvice() -> String {
        let uIntNumber = UInt32(numberOfAdvices)
        let randomAdviceIndex = Int(arc4random_uniform(uIntNumber))
        let randomAdvice = items[randomAdviceIndex]
        return randomAdvice
    }
    
    func getPreviousAdvice() -> String {
        
        //TODO: Implement this method
        
        return items[currentAdviceIndex]
    }
    
    func getNextAdvice() -> String {
        
        if currentAdviceIndex == numberOfAdvices - 1 {
            currentAdviceIndex = 0
        } else {
            currentAdviceIndex += 1
        }
        
        return items[currentAdviceIndex]
    }
    
    func parseAdvicesPlist() {
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "Advices", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        if let dict = myDict {
            for record in dict {
                
            }
        }
    }
    
    func parseAdvicesCsv() {
        if let path = Bundle.main.path(forResource: "Advices", ofType: "csv") {
            do {
                let stream = InputStream(fileAtPath: path)!
                let csv = try! CSVReader(stream: stream, hasHeaderRow: true)
                while csv.next() != nil {
                    createItemAndCategoryFromParsedRow(csv)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func createItemAndCategoryFromParsedRow(_ csv: CSVReader) {
        guard let advice = csv["Advice"] else { return }
        items.append(advice)
    }
}
