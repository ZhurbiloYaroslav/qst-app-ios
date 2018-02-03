//
//  OnlineVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 23.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        setupTableView()
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(UINib(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
    }
    
}

extension ContactsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactCell().arrayWithCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        
        switch indexPath {
        case [0,0]:
            cell.configureCellWithType(.Text)
            return cell
        case [0,1]:
            cell.configureCellWithType(.Call)
            return cell
        case [0,2]:
            cell.configureCellWithType(.Skype)
            return cell
        case [0,3]:
            cell.configureCellWithType(.Viber)
            return cell
        case [0,4]:
            cell.configureCellWithType(.WhatsApp)
            return cell
        case [0,5]:
            cell.configureCellWithType(.Email)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0,0]:
            break
        case [0,1]:
            Browser.openURLWith(.Call_Phone)
        case [0,2]:
            Browser.openURLWith(.Call_Viber)
        case [0,3]:
            Browser.openURLWith(.Call_WhatsApp)
        case [0,4]:
            Browser.openURLWith(.Call_Skype)
        case [0,5]:
            Browser.openURLWith(.Mail_Alexeykovalua)
        default:
            print("was selected undefined cell")
        }
    }
}
