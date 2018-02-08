//
//  OverviewAdviceCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 11.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class OverviewAdviceCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var adviceTitleLabel: UILabel!
    @IBOutlet weak var adviceTextLabel: UILabel!
    @IBOutlet weak var readMoreView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateCell()
    }
    
    func updateCell() {
        let advices = AdvicesManager()
        adviceTextLabel.text = advices.getRandomAdvice()
        adviceTitleLabel.text = advices.currentAdviceTitle
        characterImage.image = advices.currentCharacterImage
        readMoreView.setRadius(10, withWidth: 1, andColor: UIColor.clear)
    }

}
