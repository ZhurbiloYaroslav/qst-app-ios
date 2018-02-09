//
//  MessagesManager.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 18.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class MessagesManager {
    
    private var messageType: Message.MessageType
    private let defaults = UserDefaults.standard
    private var arrayWithMessages: [Message] = [Message]()
    
    init(messageType: Message.MessageType) {
        
        self.messageType = messageType
        parseMessagesPlist()
        
    }
    
    var numberOfAdvices: Int {
        return arrayWithMessages.count
    }
    
    func getRandomMessage() -> Message {
        
        let uIntNumber = UInt32(numberOfAdvices)
        let randomAdviceIndex = Int(arc4random_uniform(uIntNumber))
        currentAdviceIndex = randomAdviceIndex
        
        return arrayWithMessages[currentAdviceIndex]
        
    }
    
    func getCurrentMessage() -> Message {
        return arrayWithMessages[currentAdviceIndex]
    }
    
    func getPreviousMessage() -> Message {
        makeCurrentMessageIndexLower()
        return arrayWithMessages[currentAdviceIndex]
    }
    
    func getNextMessage() -> Message? {
        
        switch messageType {
            
        case .advice:
            makeCurrentMessageIndexHigher()
            return arrayWithMessages[currentAdviceIndex]
            
        case .greeting:
            makeCurrentMessageIndexHigher()
            if thereNoMoreMessages() {
                return nil
            } else {
                return arrayWithMessages[currentAdviceIndex]
            }
        }
        
    }
    
    public func doesWeHidePreviousButton() -> Bool {
        
        switch messageType {
        case .advice:
            return false
        case .greeting:
            return true
        }
        
    }
    
    public func thisIsTheLastMessage() -> Bool {
        
        switch messageType {
        case .advice:
            return false
        case .greeting:
            let doesWeReachedTheLastMessage = (currentAdviceIndex + 1) == numberOfAdvices
            return doesWeReachedTheLastMessage
        }
        
    }
    
    public func resetCurrentIndex() {
        currentAdviceIndex = 0
    }
    
}

// MARK: Calculated values
extension MessagesManager {
    
    private var currentAdviceIndex: Int {
        get {
            switch messageType {
            case .advice:
                return defaults.object(forKey: "currentAdviceIndex") as? Int ?? 0
            case .greeting:
                return defaults.object(forKey: "currentGreetingsIndex") as? Int ?? 0
            }
        }
        set {
            switch messageType {
            case .advice:
                defaults.set(newValue, forKey: "currentAdviceIndex")
                defaults.synchronize()
            case .greeting:
                defaults.set(newValue, forKey: "currentGreetingsIndex")
                defaults.synchronize()
            }
        }
    }
    
}

// MARK: Helping methods
extension MessagesManager {
    
    private func thereNoMoreMessages() -> Bool {
        return (currentAdviceIndex + 1) > arrayWithMessages.count
    }
    
    private func makeCurrentMessageIndexLower() {
        
        if currentAdviceIndex == 0 {
            currentAdviceIndex = numberOfAdvices - 1
        } else {
            currentAdviceIndex -= 1
        }
        
    }
    
    private func makeCurrentMessageIndexHigher() {
        
        if currentAdviceIndex == numberOfAdvices - 1 {
            currentAdviceIndex = 0
        } else {
            currentAdviceIndex += 1
        }
        
    }
    
    private func parseMessagesPlist() {
        
        let resourceName = getResourceName()
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "plist"),
            let arrayWithMessagesDictionaries = NSArray(contentsOfFile: path) as? [[String: Any]] else {
                return
        }
        
        for adviceDict in arrayWithMessagesDictionaries {
            let advice = Message(withDict: adviceDict, andType: messageType)
            arrayWithMessages.append(advice)
        }
        
    }
    
    private func getResourceName() -> String {
        
        switch messageType {
        case .advice:
            return  "Advices"
        case .greeting:
            return "Greetings"
        }
        
    }
    
}
