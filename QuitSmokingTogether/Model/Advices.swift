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
    
    var items: [String] = []
    var currentAdviceIndex = 0
    
    init() {
        parseAdvicesCsv()
    }
    
    var numberOfAdvices: Int {
        return items.count
    }
    
    func getNextAdvice() -> String {
        
        if currentAdviceIndex == numberOfAdvices - 1 {
            currentAdviceIndex = 0
        } else {
            currentAdviceIndex += 1
        }
        
        return items[currentAdviceIndex]
    }
    
    //TODO: Implement getRandomAdvice()
    func getRandomAdvice() -> String {
        return ""
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
