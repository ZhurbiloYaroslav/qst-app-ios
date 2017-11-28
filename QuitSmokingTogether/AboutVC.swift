//
//  AboutVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 21.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class AboutVC: UITableViewController {

    @IBOutlet weak var appVersionCell: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func updateLabelsText() {
        //TODO: Make App writes its own version
        appVersionCell.detailTextLabel?.text = "1.00"
    }
    
    @IBAction func websiteButtonPressed(_ sender: UIButton) {
        Browser.openURLWith(.DigLabStudio)
    }

}
