//
//  getHtmlFormat.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 11.04.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

extension String {
    
    var utfData: Data? {
        return self.data(using: .utf8)
    }

    var html2AttributedString: NSAttributedString {
        return Data(utf8).html2AttributedString
    }
    
    var html2String: String {
        return html2AttributedString.string
    }
    
}

extension Data {
    var html2AttributedString: NSAttributedString {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  NSAttributedString()
        }
    }
    var html2String: String {
        return html2AttributedString.string
    }
}
