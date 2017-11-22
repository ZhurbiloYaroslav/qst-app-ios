//
//  OverviewCompCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 21.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class OverviewCompCell: UITableViewCell {
    
    @IBOutlet weak var competitionTitleLabel: UILabel!
    @IBOutlet weak var competitionTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateCell()
    }
    
    func updateCell() {
        let advices = Advices()
        competitionTitleLabel.text = advices.currentAdviceTitle
        competitionTextLabel.text = advices.getRandomAdvice()
    }

}
