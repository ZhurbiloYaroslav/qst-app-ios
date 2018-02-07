//
//  EventsListVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 23.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class EventsListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterStack: UIStackView!
    @IBOutlet weak var constraintHeightForFilterStack: NSLayoutConstraint!
    
    let eventsManager = EventsManager.shared
    let eventsFilter = EventsFilter.shared
    
    var eventToPresentFromOverview: Event?
    var doWePresentEventFromOverview = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //AdMobManager().getFullScreenInterstitialForVC(self)
        
        eventsManager.eventsData.getEventsFromServer {
            self.tableView.reloadData()
        }
        setDelegates()
        switchFilterVisibility()
        setupTableView()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //tableView.reloadData()
        presentEventFromOverview()
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func presentEventFromOverview() {

        if let event = eventToPresentFromOverview, doWePresentEventFromOverview {
            doWePresentEventFromOverview = false
            
            if let articleDescVC = ArticleDescVC.getInstance() {
                articleDescVC.currentArticle = event
                navigationController?.pushViewController(articleDescVC, animated: true)
            }
        }
    }
    
    func updateUI() {
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func switchFilterVisibility() {
        if constraintHeightForFilterStack.constant == 0 {
            constraintHeightForFilterStack.constant = 71
            filterStack.isHidden = !filterStack.isHidden
        } else {
            constraintHeightForFilterStack.constant = 0
            filterStack.isHidden = !filterStack.isHidden
        }
    }
    
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        switchFilterVisibility()
    }
    
    @IBAction func eventStatusControlValueChanged(_ sender: UISegmentedControl, forEvent event: UIEvent) {
        switch sender.selectedSegmentIndex {
        case 1:
            eventsFilter.eventStatus = .Unread
        case 2:
            eventsFilter.eventStatus = .Starred
        default:
            eventsFilter.eventStatus = .All
        }
        reloadTable()
    }
    
    @IBAction func eventTypeControlValueChanged(_ sender: UISegmentedControl, forEvent event: UIEvent) {
        switch sender.selectedSegmentIndex {
        case 1:
            eventsFilter.eventType = .News
        case 2:
            eventsFilter.eventType = .Competition
        default:
            eventsFilter.eventType = .All
        }
        reloadTable()
    }
}

extension EventsListVC: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsManager.getNumberOfEvents()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        let event = eventsManager.getEventFor(indexPath)
        cell.updateWith(event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let articleDescVC = ArticleDescVC.getInstance() {
            articleDescVC.currentArticle = eventsManager.getEventFor(indexPath)
            navigationController?.pushViewController(articleDescVC, animated: true)
        }
    }
}



