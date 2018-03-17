//
//  LanguageCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 12.03.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    @IBOutlet weak var languageLabel: UILabel!
    
    func updateWith(_ text: String) {
        languageLabel.text = text
    }

}
