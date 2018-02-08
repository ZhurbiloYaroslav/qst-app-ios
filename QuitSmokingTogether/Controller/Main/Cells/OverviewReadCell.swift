//
//  OverviewReadCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 10.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class OverviewReadCell: UITableViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookTextLabel: UILabel!
    @IBOutlet weak var continueReadingView: UILabel!
    
    func updateCell() {
        bookTitleLabel.text = UserDefaultsManager().chapterInText
        bookTextLabel.text = UserDefaultsManager().firstParagraphInText
        continueReadingView.setRadius(10, withWidth: 1, andColor: UIColor.clear)
    }

}
