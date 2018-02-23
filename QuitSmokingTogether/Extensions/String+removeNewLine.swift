//
//  String+removeNewLine.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 23.02.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

extension String {
    func removeNewLines() -> String {
        return self.replacingOccurrences(of: "\n", with: "")
    }
}
