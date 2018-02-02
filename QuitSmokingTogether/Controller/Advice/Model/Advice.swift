//
//  Advice.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 31.01.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

struct Advice {
    var title: String
    var message: String
    var image: UIImage
    
    init(withDict dictionary: [String: Any]) {
        let adviceID = dictionary["id"] as? String ?? "01"
        let adviceTitleString = "advice_" + adviceID + "_title"
        let adviceMessageString = "advice_" + adviceID + "_message"
        let adivceImageString = dictionary["image"] as? String ?? ""
        self.title = adviceTitleString.localized()
        self.message = adviceMessageString.localized()
        self.image = UIImage(named: adivceImageString) ?? UIImage()
    }
}
