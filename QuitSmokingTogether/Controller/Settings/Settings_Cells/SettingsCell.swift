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
    
    func updateAs(_ type: SettingsCellType) {
        languageLabel.text = getCellTitleDependsOn(type)
    }
    
    func getCellTitleDependsOn(_ type: SettingsCellType) -> String {
        switch type {
        case .language:
            return "cell_language_title".localized()
        case .share:
            return "cell_share_title".localized()
        case .likeOnAppStore:
            return "cell_likeOnAppStore_title".localized()
        case .removeAdvert:
            return "cell_removeAdvert_title".localized()
        case .contacts:
            return "contacts_screen_title".localized()
        case .about:
            return "cell_about_title".localized()
        }
    }
    
    enum SettingsCellType {
        case language
        case share
        case likeOnAppStore
        case removeAdvert
        case contacts
        case about
    }

}
