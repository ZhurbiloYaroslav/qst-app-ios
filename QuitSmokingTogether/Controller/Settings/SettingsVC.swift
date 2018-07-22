//
//  SettingsVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 10.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import FacebookCore
import FirebaseAuth
import FBSDKLoginKit
import FBSDKShareKit

class SettingsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var facebookLikeButton = FBSDKLikeControl()
    private var facebookLoginButton = FBSDKLoginButton()
    
    private let userDefaultsManager = UserDefaultsManager()
    
    var totalNumberOfCellsAndHeaders = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        setupFacebookLikeButton()
        setupFacebookLoginButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        (tabBarController as! TabBarVC).localizeUI()
        localizeUI()
        hideLoginButton()
    }
    
    func hideLoginButton() {
        facebookLoginButton.isHidden = isLoggedToFacebook
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func localizeUI() {
        navigationItem.title = "settings_screen_title".localized()
    }
    
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        case 2:
            return 2
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
        case [0,1]: // Language
            let cell = tableView.dequeueReusableCell(withIdentifier: "Language", for: indexPath) as! SettingsCell
            cell.updateAs(.language)
            return cell
        case [1,0]: // Share
            let cell = tableView.dequeueReusableCell(withIdentifier: "Share", for: indexPath) as! SettingsCell
            cell.updateAs(.share)
            return cell
//        case [1,1]: // Like on App Store
//            let cell = tableView.dequeueReusableCell(withIdentifier: "LikeOnAppStore", for: indexPath) as! SettingsCell
//            cell.updateAs(.likeOnAppStore)
//            return cell
        case [1,1]: // Like on Facebook
            let cell = tableView.dequeueReusableCell(withIdentifier: "LikeOnFacebook", for: indexPath) as UITableViewCell
            // https://github.com/facebook/facebook-sdk-swift/blob/master/Sources/Share/Views/LikeButton.swift
            showFacebookLikeButtonIn(cell)
            showFacebookLoginButtonIn(cell)
            return cell
//        case [2,0]: // Remove advert
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Advert", for: indexPath) as! SettingsCell
//            cell.updateAs(.removeAdvert)
//            return cell
        case [2,0]: // Contacts
            let cell = tableView.dequeueReusableCell(withIdentifier: "Contacts", for: indexPath) as! SettingsCell
            cell.updateAs(.contacts)
            return cell
        case [2,1]: // About
            let cell = tableView.dequeueReusableCell(withIdentifier: "About", for: indexPath) as! SettingsCell
            cell.updateAs(.about)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0,0]: // Account
            performSegue(withIdentifier: "ShowProfileFromSettings", sender: nil)
        case [0,1]: // Language
            if let languageVC = LanguagePickerVC.getInstance() {
                navigationController?.pushViewController(languageVC, animated: true)
                //self.present(languageVC, animated: true)
            }
        case [1,0]: // Share
            performSegue(withIdentifier: "ShowShareFromSettings", sender: nil)
//        case [1,1]: // Like on App Store
//            Browser.openURLWith(.AppInItunes)
        case [1,1]: // Like on Facebook
            break
//        case [2,0]: // Remove advert
//            performSegue(withIdentifier: "ShowRemoveAdvertFromSettings", sender: nil)
        case [2,0]: // Contacts
            performSegue(withIdentifier: "ShowContactsFromSettings", sender: nil)
        case [2,1]: // About
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
        if (section == 3) {
            footerView.backgroundColor = UIColor.clear
        } else {
            footerView.backgroundColor = Constants.Color.green
        }
        
        return footerView
        
    }
    
}

extension SettingsVC: FBSDKLoginButtonDelegate {
    
    private var isLoggedToFacebook: Bool {
        return FBSDKAccessToken.current() != nil
    }
    
    private func setupFacebookLoginButton() {
        facebookLoginButton = FBSDKLoginButton()
        facebookLoginButton.delegate = self
    }
    
    func setupFacebookLikeButton() {
        facebookLikeButton = FBSDKLikeControl()
        facebookLikeButton.objectID = "http://quitsmokingtogether.org"
        facebookLikeButton.likeControlStyle = .boxCount
    }
    
    func showFacebookLikeButtonIn(_ cell: UITableViewCell) {
        if let fbButtonView = cell.viewWithTag(8), isLoggedToFacebook {
            let bounds = fbButtonView.bounds
            facebookLikeButton.frame = CGRect(x: 30, y: (bounds.midY - ((bounds.height + 4 ) / 2)), width: bounds.width, height: bounds.height)
            fbButtonView.insertSubview(facebookLikeButton, aboveSubview: cell.viewWithTag(9)!)
        }
    }
    
    func showFacebookLoginButtonIn(_ cell: UITableViewCell) {
        hideLoginButton()
        if let fbButtonView = cell.viewWithTag(8), !isLoggedToFacebook {
            let bounds = fbButtonView.bounds
            facebookLoginButton.frame = CGRect(x: 30, y: (bounds.midY - ((bounds.height + 4 ) / 2)), width: (bounds.width / 3), height: bounds.height)
            fbButtonView.insertSubview(facebookLoginButton, aboveSubview: cell.viewWithTag(9)!)
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        hideLoginButton()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did logout")
    }
}
