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

        updateLabelsText()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func updateLabelsText() {
        appVersionCell.detailTextLabel?.text = Constants.AppInfo.versionAndBuild
    }
    
    @IBAction func websiteButtonPressed(_ sender: UIButton) {
        Browser.openURLWith(.Soft4Status)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [1,0]:
            Browser.openURLWith(.Surf_QSTWebsite)
        case [2,0]:
            Browser.openURLWith(.Surf_LinkedIn_Yaroslav)
        case [2,1]:
            Browser.openURLWith(.Surf_LinkedIn_Yaroslav)
        default:
            break
        }
    }

}
