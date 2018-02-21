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
    var eventsManager = EventsManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsManager.eventsData.getEventsFromServer {
            self.tableView.reloadData()
        }
        setDelegates()
        setupTableView()
        updateUIWithLocalizedText()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        //tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(UINib(nibName: "OverviewEventCell", bundle: nil), forCellReuseIdentifier: "OverviewEventCell")
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func readMoreEventButtonPressed(_ sender: UIButton) {
        let newsTag = OverviewEventCell.ReadMoreButtonTag.News.rawValue
        let compTag = OverviewEventCell.ReadMoreButtonTag.Competitions.rawValue
        
        switch sender.tag {
        case newsTag:
            showEventDescriptionWith(type: .News)
        case compTag:
            showEventDescriptionWith(type: .Competition)
        default:
            print("was pressed undefined button")
        }
    }
    
}

extension OverviewVC {
    func updateUIWithLocalizedText() {
        navigationItem.title = "overview_screen_title".localized()
    }
}

extension OverviewVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath {
        case [0,0]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewReadCell", for: indexPath) as! OverviewReadCell
            cell.updateCell()
            return cell
            
        case [0,1]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewAdviceCell", for: indexPath) as! OverviewAdviceCell
            cell.updateCell()
            return cell
            
        case [0,2]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewEventCell", for: indexPath) as! OverviewEventCell
            cell.updateCellFor(eventType: .News)
            cell.readMoreButton.addTarget(self, action: #selector(readMoreEventButtonPressed(_:)), for: .touchUpInside)
            return cell
            
        case [0,3]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewEventCell", for: indexPath) as! OverviewEventCell
            cell.updateCellFor(eventType: .Competition)
            cell.readMoreButton.addTarget(self, action: #selector(readMoreEventButtonPressed(_:)), for: .touchUpInside)
            return cell
            
        case [0,4]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewContactsCell", for: indexPath) as! OverviewContactsCell
            cell.updateWithType(.contacts)
            return cell
            
        case [0,5]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewContactsCell", for: indexPath) as! OverviewContactsCell
            cell.updateWithType(.ngo)
            return cell
            
        case [0,6]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewContactsCell", for: indexPath) as! OverviewContactsCell
            cell.updateWithType(.shirts)
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
            showEventDescriptionWith(type: .Competition)
        case [0,4]:
            showContactsView()
        case [0,5]:
            showNGOView()
        case [0,6]:
            showShirtsView()
        default:
            return
        }
    }
    
}

// MARK: Supporting methods
extension OverviewVC {
    
    func showReader() {
        tabBarController?.selectedIndex = 2
    }
    
    func showAdviceView() {
        if let messagesVC = AdviceVC.getInstance() {
            messagesVC.messagesManager = MessagesManager(messageType: .advice)
            navigationController?.pushViewController(messagesVC, animated: true)
        }
    }
    
    func showEventDescriptionWith(type: Event.EventType) {
        
        if let navController = self.tabBarController?.viewControllers?[1] as? UINavigationController{
            if let eventsListController = navController.childViewControllers.first as? EventsListVC {
                
                let event = EventsData.shared.getFirstEventWithType(type, andStatus: .Unread)
                eventsListController.eventToPresentFromOverview = event
                eventsListController.doWePresentEventFromOverview = true
                self.tabBarController?.selectedIndex = 1
            }
        }
        
    }
    
    func showContactsView() {
        if let contactsVC = ContactsVC.getInstance() {
            navigationController?.pushViewController(contactsVC, animated: true)
        }
    }
    
    func showNGOView() {
        
    }
    
    func showShirtsView() {
        
    }
    
}
