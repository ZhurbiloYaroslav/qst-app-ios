//
//  Date+addedBy.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 15.02.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

extension Date {
    
    func addedBy(minutes:Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    
}
