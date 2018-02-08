//
//  OverviewContactsCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 11.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class OverviewContactsCell: UITableViewCell {

    @IBOutlet weak var helpTextLabel: UILabel!
    @IBOutlet weak var readMoreView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        readMoreView.setRadius(10, withWidth: 1, andColor: UIColor.clear)
    }

}
