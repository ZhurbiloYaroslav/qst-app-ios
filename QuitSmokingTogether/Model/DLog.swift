//
//  DLog.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 17.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

struct DLog {
    static func show(message: String, file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
        print("\(file) : \(function) : \(line) : \(column) - \(message)")
    }
}
