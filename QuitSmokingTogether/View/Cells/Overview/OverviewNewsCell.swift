//
//  OverviewLastNewsCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 21.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class OverviewNewsCell: UITableViewCell {
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateCell()
    }
    
    func updateCell() {
        let advices = Advices()
        newsTitleLabel.text = advices.currentAdviceTitle
        newsTextLabel.text = advices.getRandomAdvice()
    }

}
