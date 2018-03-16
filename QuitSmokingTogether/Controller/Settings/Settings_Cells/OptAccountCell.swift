//
//  OptAccountCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 16.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class OptAccountCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var accountName: UILabel!
    
    func update() {
        cellTitle.text = "cell_account_title".localized()
        accountName.text = CurrentUser.accountName
    }
}
