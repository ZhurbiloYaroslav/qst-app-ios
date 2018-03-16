//
//  OverviewAdviceCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 11.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class OverviewAdviceCell: UITableViewCell {

    @IBOutlet weak var cellHeader: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var adviceTitleLabel: UILabel!
    @IBOutlet weak var adviceTextLabel: UILabel!
    @IBOutlet weak var readMoreView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateCell()
    }
    
    func updateCell() {
        cellHeader.text = "section_advices".localized()
        
        let advices = MessagesManager(messageType: .advice)
        let randomMessage = advices.getRandomMessage()
        adviceTextLabel.text = randomMessage.text
        adviceTitleLabel.text = randomMessage.title
        characterImage.image = randomMessage.image
        readMoreView.setRadius(10, withWidth: 1, andColor: UIColor.clear)
        readMoreView.text = "button_readmore".localized()
    }

}
