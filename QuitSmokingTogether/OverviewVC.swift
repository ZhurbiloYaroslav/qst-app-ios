//
//  OverviewVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 30.09.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class OverviewVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func setDelegates() {
        tableView.delegate = self
    }

}

extension OverviewVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath {
        case [0,0]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "overviewReadCell", for: indexPath) as! OverviewReadCell
            cell.bookTextLabel.text = "Here will be the text of the last chapter"
            return cell
            
        case [0,1]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "overviewAdviceCell", for: indexPath) as! OverviewAdviceCell
            cell.adviceTextLabel?.text = "Here will be the text of advice"
            return cell
            
        case [0,2]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "overviewHelpCell", for: indexPath) as! OverviewHelpCell
            cell.helpTextLabel?.text = "Here will be the text of help cell"
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
}

