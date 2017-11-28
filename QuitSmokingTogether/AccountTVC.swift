//
//  AccountTVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 25.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FirebaseAuth

class AccountTVC: UITableViewController {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var logOutLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillLabelsWithValues()
    }
    
    func fillLabelsWithValues() {
        firstNameLabel.text = CurrentUser.name
        lastNameLabel.text = CurrentUser.name
        userEmailLabel.text = CurrentUser.email
        userPhoneLabel.text = CurrentUser.phone
        logOutLabel.text = "Log Out from \(CurrentUser.provider.rawValue)"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0,0]:
            print("First")
            break
        case [0,1]:
            print("Last")
            break
        case [1,0]:
            print("Email")
            break
        case [1,1]:
            print("Password")
            break
        case [2,0]:
            print("Phone")
            break
        case [3,0]:
            print("Logout")
//            CurrentUser.logOut() {
//                self.fillLabelsWithValues()
//            }
            break
        default:
            break
        }
    }

}
