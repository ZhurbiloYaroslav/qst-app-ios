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
        
        readMoreView.text = "button_readmore".localized()
        
        switch type {
        case .share:
            updateUIWith(image: UIImage(named: "character-thumbs-up") ?? UIImage(),
                         title: "share_title".localized(),
                         message: "share_fragment".localized()
            )
            cellImage.contentMode = .scaleAspectFit
            readMoreView.text = "button_share".localized()
            
        case .contacts:
            updateUIWith(image: UIImage(named: "image-contacts") ?? UIImage(),
                         title: "contacts_screen_title".localized(),
                         message: "contacts_fragment".localized()
            )
            
        case .ngo:
            updateUIWith(image: UIImage(named: "image-ngo") ?? UIImage(),
                         title: "ngo_screen_title".localized(),
                         message: "ngo_screen_message".localized()
            )
            
        case .shirts:
            updateUIWith(image: UIImage(named: "image-shirt-1") ?? UIImage(),
                         title: "shirts_screen_title".localized(),
                         message: "shirts_text_message".localized()
            )
            messageLabel.numberOfLines = 3
        }
    }
    
    private func updateUIWith(image: UIImage, title: String, message: String) {
        cellImage.image = image
        titleLabel.text = title
        messageLabel.text = message.removeNewLines()
    }
    
    public enum CellType {
        case share
        case contacts
        case ngo
        case shirts
    }

}
