//
//  ContactCell.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 27.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var contactIcon: UIImageView!
    @IBOutlet weak var iconBackground: UIView!
    @IBOutlet weak var contactTitle: UILabel!
    @IBOutlet weak var contactAddress: UITextField!
    
    var arrayWithCells: [Cell] = [
        Cell(type: .Undefined, icon: UIImage(), title: "", value: ""), // This will be Image cell
        Cell(type: .Undefined, icon: UIImage(), title: "", value: ""), // This will be Image cell
        Cell(type: .Call, icon: #imageLiteral(resourceName: "icon-call"), title: "Phone/fax:", value: "+38 (050) 202-23-02"),
        Cell(type: .Skype, icon: #imageLiteral(resourceName: "icon-skype"), title: "Skype:", value: "alexeykovalua"),
        Cell(type: .Viber, icon: #imageLiteral(resourceName: "icon-viber"), title: "Viber:", value: "+380502022302"),
        Cell(type: .WhatsApp, icon: #imageLiteral(resourceName: "icon-whatsapp"), title: "WhatsApp:", value: "+380502022302"),
        Cell(type: .Email, icon: #imageLiteral(resourceName: "icon-gmail-online"), title: "Email:", value: "quitsmokingtogether@gmail.com")
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconBackground.setRadius(30, withWidth: 1, andColor: UIColor.clear)
    }
    
    func configureCellWithType(_ cellType: CellType) {
        
        if cellType == .Text {
            contactIcon.isHidden = true
            contactTitle.isHidden = true
            contactAddress.textColor = UIColor.darkGray
        }
        
        for cell in arrayWithCells {
            if cell.type == cellType {
                contactIcon.image = cell.icon
                contactTitle.text = cell.title
                contactAddress.text = cell.value
            }
        }
    }
    
    struct Cell {
        let type: CellType
        let icon: UIImage
        let title: String
        let value: String
    }
    
    enum CellType {
        case Text
        case Call
        case Skype
        case Viber
        case WhatsApp
        case Email
        case Undefined
    }
    
}
