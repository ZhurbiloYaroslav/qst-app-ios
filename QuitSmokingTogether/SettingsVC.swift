//
//  SettingsVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 10.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let userDefaultsManager = UserDefaultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath {
        case [0,0]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountName", for: indexPath) as! OptAccountCell
            cell.update()
            return cell
        case [1,0]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FAQ", for: indexPath) as UITableViewCell
            return cell
        case [1,1]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Share", for: indexPath) as UITableViewCell
            return cell
        case [1,2]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Donate", for: indexPath) as UITableViewCell
            return cell
        case [2,0]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Advert", for: indexPath) as UITableViewCell
            return cell
        case [2,1]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "About", for: indexPath) as UITableViewCell
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        if (section == 2) {
            headerView.backgroundColor = Constants.Color.green
        } else {
            headerView.backgroundColor = UIColor.clear
        }
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 1))
        if (section == 0) {
            footerView.backgroundColor = Constants.Color.green
        } else {
            footerView.backgroundColor = UIColor.clear
        }
        
        return footerView
        
    }
    
}
