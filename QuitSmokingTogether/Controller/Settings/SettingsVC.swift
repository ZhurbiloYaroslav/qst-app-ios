//
//  SettingsVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 10.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKShareKit

class SettingsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var facebookLikeButton = FBSDKLikeControl()
    
    private let userDefaultsManager = UserDefaultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        setupFacebookLikeButton()

    }
    
    func setupFacebookLikeButton() {
        let likeButton:FBSDKLikeControl = FBSDKLikeControl()
        likeButton.objectID = "http://quitsmokingtogether.org"
        likeButton.likeControlStyle = .boxCount
        facebookLikeButton = likeButton
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 2
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath {
        case [0,0]: // Account
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountName", for: indexPath) as! OptAccountCell
            cell.update()
            return cell
        case [1,0]: // Share
            let cell = tableView.dequeueReusableCell(withIdentifier: "Share", for: indexPath) as UITableViewCell
            return cell
        case [1,1]: // Like on App Store
            let cell = tableView.dequeueReusableCell(withIdentifier: "LikeOnAppStore", for: indexPath) as UITableViewCell
            return cell
        case [1,2]: // Like on Facebook
            let cell = tableView.dequeueReusableCell(withIdentifier: "LikeOnFacebook", for: indexPath) as UITableViewCell
            facebookLikeButton.frame = CGRect(x: 68, y: 12, width: cell.frame.width, height: cell.frame.height)
            cell.insertSubview(facebookLikeButton, at: 2)
            return cell
        case [2,0]: // Remove advert
            let cell = tableView.dequeueReusableCell(withIdentifier: "Advert", for: indexPath) as UITableViewCell
            return cell
        case [2,1]: // Donate
            let cell = tableView.dequeueReusableCell(withIdentifier: "Donate", for: indexPath) as UITableViewCell
            return cell
//        case [3,0]: // FAQ
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FAQ", for: indexPath) as UITableViewCell
//            return cell
        case [3,0]: // About
            let cell = tableView.dequeueReusableCell(withIdentifier: "About", for: indexPath) as UITableViewCell
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0,0]: // Account
            performSegue(withIdentifier: "ShowProfileFromSettings", sender: nil)
        case [1,0]: // Share
            performSegue(withIdentifier: "ShowShareFromSettings", sender: nil)
        case [1,1]: // Like on App Store
            Browser.openURLWith(.AppInItunes)
        case [1,2]: // Like on Facebook
            break
        case [2,0]: // Remove advert
            performSegue(withIdentifier: "ShowRemoveAdvertFromSettings", sender: nil)
        case [2,1]: // Donate
            performSegue(withIdentifier: "ShowDonateFromSettings", sender: nil)
//        case [3,0]: // FAQ
//            performSegue(withIdentifier: "ShowFAQFromSettings", sender: nil)
        case [3,0]: // About
            performSegue(withIdentifier: "ShowAboutFromSettings", sender: nil)
        default:
            print("was selected undefined cell")
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        if (section == 0) {
            headerView.backgroundColor = UIColor.clear
        } else {
            headerView.backgroundColor = Constants.Color.green
        }
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 1))
        if (section == 2) {
            footerView.backgroundColor = UIColor.clear
        } else {
            footerView.backgroundColor = Constants.Color.green
        }
        
        return footerView
        
    }
    
}
