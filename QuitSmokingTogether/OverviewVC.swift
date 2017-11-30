//
//  OverviewVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 30.09.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import FolioReaderKit

class OverviewVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var eventToPresent: Event?
    var doWePresentEventPressedOnEventCell = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension

    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tabBarController?.delegate = self
    }
    
    @IBAction func continueReadingButtonPressed(_ sender: UIButton) {
        showReader()
    }
    @IBAction func readMoreButtonPressed(_ sender: UIButton) {
        showAdviceView()
    }
    
    func showReader() {
        tabBarController?.selectedIndex = 1
    }
    
    func showAdviceView() {
        performSegue(withIdentifier: "showAdviceFromOverview", sender: nil)
    }
    
    func showEventDescriptionWith(type: Event.EventType) {
        eventToPresent = EventsList.getFirstEventWithType(type, andStatus: .Unread)
        doWePresentEventPressedOnEventCell = true
        self.tabBarController?.selectedIndex = 1

    }
    
    func showOnlineView() {
        tabBarController?.selectedIndex = 3
    }
    
}

extension OverviewVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if doWePresentEventPressedOnEventCell {
            let viewController  = tabBarController.viewControllers?[1] as! EventsListVC
            viewController.eventToPresentFromOverview = eventToPresent
        }
        
        return true
    }
}

extension OverviewVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath {
        case [0,0]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewReadCell", for: indexPath) as! OverviewReadCell
            cell.updateCell()
            return cell
            
        case [0,1]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewAdviceCell", for: indexPath) as! OverviewAdviceCell
            return cell
            
        case [0,2]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewEventCell", for: indexPath) as! OverviewEventCell
            cell.updateCellFor(eventType: .News)
            return cell
            
        case [0,3]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewEventCell", for: indexPath) as! OverviewEventCell
            cell.updateCellFor(eventType: .Competiton)
            return cell
            
        case [0,4]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewHelpCell", for: indexPath) as! OverviewHelpCell
            cell.helpTextLabel?.text = "Here will be the text of help cell"
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0,0]:
            showReader()
        case [0,1]:
            showAdviceView()
        case [0,2]:
            showEventDescriptionWith(type: .News)
        case [0,3]:
            showEventDescriptionWith(type: .Competiton)
        case [0,4]:
            showOnlineView()
        default:
            return
        }
    }
    
}

