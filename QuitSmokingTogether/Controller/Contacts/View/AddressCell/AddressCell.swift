//
//  AddressCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 17.02.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var addressTextView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        organizationNameLabel.text = "contacts_text_organization".localized()
        addressTextView.text = "contacts_text_message".localized()
    }
    
}
