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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()

    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = "Label"
        cell.detailTextLabel?.text = "Desc"
        
        return cell
    }
    
}
