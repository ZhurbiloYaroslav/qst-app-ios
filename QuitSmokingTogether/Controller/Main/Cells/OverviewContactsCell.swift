//
//  OverviewContactsCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 11.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class OverviewContactsCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var readMoreView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        readMoreView.setRadius(10, withWidth: 1, andColor: UIColor.clear)
    }
    
    public func updateWithType(_ type: CellType) {
        switch type {
        case .contacts:
            updateUIWith(image: UIImage(named: "image-contacts") ?? UIImage(),
                         title: "Contacts",
                         message: "Dear friend, you can contact with me and I will help you to quit smoking!"
            )
        case .ngo:
            updateUIWith(image: UIImage(named: "image-ngo") ?? UIImage(),
                         title: "NGO title",
                         message: "NGO message text"
            )
        case .shirts:
            updateUIWith(image: UIImage(named: "dsc06257") ?? UIImage(),
                         title: "Shirts",
                         message: "Shirts message text"
            )
        }
    }
    
    private func updateUIWith(image: UIImage, title: String, message: String) {
        cellImage.image = image
        titleLabel.text = title
        messageLabel.text = message
    }
    
    public enum CellType {
        case contacts
        case ngo
        case shirts
    }

}
