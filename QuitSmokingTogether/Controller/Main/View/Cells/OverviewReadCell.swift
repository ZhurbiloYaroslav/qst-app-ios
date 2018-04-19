//
//  OverviewReadCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 10.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class OverviewReadCell: UITableViewCell {

    @IBOutlet weak var bookCoverImage: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookTextLabel: UILabel!
    @IBOutlet weak var continueReadingView: UILabel!
    
    func updateCell() {
        bookCoverImage.image = getLocalizedCover()
        bookTitleLabel.text = UserDefaultsManager().chapterInText
        bookTextLabel.text = UserDefaultsManager().firstParagraphInText
        continueReadingView.setRadius(10, withWidth: 1, andColor: UIColor.clear)
        continueReadingView.text = "button_continue_reading".localized()
    }
    
    func getLocalizedCover() -> UIImage? {
        var imageName = "book-cover-"
        switch LanguageManager.shared.currentLanguage {
        case .russian: imageName += "ru"
        default: imageName += "en"
        }
        return UIImage(named: imageName)
    }

}
