//
//  FAQCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 16.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class FAQCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var questionTitle: UILabel!
    
    func update(item: FAQ.Item) {
        questionTitle.text = item.question
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
