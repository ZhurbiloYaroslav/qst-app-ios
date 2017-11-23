//
//  Image.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 23.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class Image {
    
    var localAddress: String!
    var urlAddress: String!
    
    init(localAddress: String, urlAddress: String) {
        self.localAddress = localAddress
        self.urlAddress = urlAddress
    }
    
    convenience init(localAddress: String) {
        self.init(localAddress: localAddress, urlAddress: "")
    }
    
    convenience init(urlAddress: String) {
        self.init(localAddress: "", urlAddress: urlAddress)
    }
}
