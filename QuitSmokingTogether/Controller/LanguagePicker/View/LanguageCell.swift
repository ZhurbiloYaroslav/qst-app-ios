//
//  LanguageCell.swift
//  UREClub
//
//  Created by Yaroslav Zhurbilo on 26.01.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell {

    @IBOutlet weak var langImage: UIImageView!
    @IBOutlet weak var nativeTitleLabel: UILabel!
    
    var currentLanguage: Language!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCellWith(_ language: Language) {
        currentLanguage = language
        langImage.image = getLangImage(language)
        nativeTitleLabel.text = language.getNativeName()
    }
    
    func getLangImage(_ language: Language) -> UIImage {
        switch language {
        case .russian:
            return UIImage(named: "icon-lang-ru") ?? #imageLiteral(resourceName: "icon-lang-ru")
        default:
            return UIImage(named: "icon-lang-en") ?? #imageLiteral(resourceName: "icon-lang-en")
        }
    }

}
