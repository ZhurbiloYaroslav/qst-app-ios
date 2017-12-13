//
//  ReaderText.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 22.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class ReaderText {
    func getFirstParagraphInText() -> String {
        let defaults = UserDefaultsManager()
        return defaults.firstParagraphInText
    }
}
