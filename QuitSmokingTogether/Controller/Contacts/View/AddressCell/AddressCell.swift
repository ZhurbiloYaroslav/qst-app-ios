//
//  AddressCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 17.02.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet weak var addressTextView: UILabel!
    @IBOutlet weak var mapImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addressTextView.text = "contacts_text_message".localized()
    }
    
}
