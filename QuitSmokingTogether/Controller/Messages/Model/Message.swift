//
//  Message.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 31.01.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

struct Message {
    
    var title: String
    var text: String
    var image: UIImage
    var type: MessageType
    
    init(withDict dictionary: [String: Any], andType type: MessageType) {
        
        let adviceID = dictionary["id"] as? String ?? "01"
        let adivceImageString = dictionary["image"] as? String ?? ""
        
        self.title = Message.getTitle(withID: adviceID, andType: type)
        self.text = Message.getText(withID: adviceID, andType: type)
        self.image = UIImage(named: adivceImageString) ?? UIImage()
        self.type = type
        
    }
    
    enum MessageType {
        case advice
        case greeting
    }
}

extension Message {
    
    private static func getNamePrefix(withType type: MessageType) -> String {
        switch type {
        case .advice:
            return "advice_"
        case .greeting:
            return "greeting_"
        }
    }
    
    private static func getTitle(withID id: String, andType type: MessageType) -> String {
        switch type {
        case .advice:
            let newTitle = Message.getNamePrefix(withType: type) + id + "_title"
            return newTitle.localized()
        case .greeting:
            return ""
        }
    }
    
    private static func getText(withID id: String, andType type: MessageType) -> String {
        let newText = Message.getNamePrefix(withType: type) + id + "_message"
        return newText.localized()
    }
}


