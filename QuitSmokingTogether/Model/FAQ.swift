//
//  FAQ.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 16.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class FAQ {
    
    var sections: [Section] = []
    var items: [[Item]] = []
    
    init() {
        parseFAQPlist()
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return items[section].count
    }
    
    func getItemForIndexPath(_ indexPath: IndexPath) -> Item {
        return items[indexPath.section][indexPath.row]
    }
    
    func getSectionWithIndex(_ index: Int) -> Section {
        return sections[index]
    }
    
    func parseFAQPlist() {

        guard let path = Bundle.main.path(forResource: "FAQ", ofType: "plist"),
            let arrayWithFAQDictionaries = NSArray(contentsOfFile: path) as? [[String: Any]] else {
                return
        }
        
        for faqDict in arrayWithFAQDictionaries {
            createItemAndCategoryFromParsedRow(faqDict)
        }
        
    }
    
    func createItemAndCategoryFromParsedRow(_ faqDict: [String: Any]) {
        
        guard let sectionName = faqDict["Section"] as? String else { return }
        guard let question = faqDict["Question"] as? String else { return }
        guard let answer = faqDict["Answer"] as? String else { return }
        
        var section = Section(name: sectionName)
        if let sectionIndex = sections.index(where: {$0.name == sectionName}) {
            section = sections[sectionIndex]
        } else {
            sections.append(section)
        }
        let faqItem = Item(section: section, question: question, answer: answer)
        
        updateArraysWithValues(section: section, item: faqItem)
        
    }
    
    func updateArraysWithValues(section: Section, item: Item) {
        
        if let sectionIndex = sections.index(where: {$0.name == section.name}) {
            if items.indices.contains(sectionIndex) {
                items[sectionIndex].append(item)
            } else {
                items.append([item])
            }
        }
    }
    
    class Item {
        var section: Section
        var question: String
        var answer: String
        
        init(section: Section, question: String, answer: String) {
            self.section = section
            self.question = question
            self.answer = answer
        }
    }
    
    class Section {
        var name: String
        
        init(name: String) {
            self.name = name
        }
        
    }
}
