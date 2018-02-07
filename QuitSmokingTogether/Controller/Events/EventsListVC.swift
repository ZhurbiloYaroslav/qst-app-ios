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
    
    var arrayWithEvents: [Event] = [Event]()
    let eventManager = EventsManager()
    var eventsFilter = EventsFilter()
    
    var eventToPresentFromOverview: Event?
    var doWePresentEventFromOverview = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdMobManager().getFullScreenInterstitialForVC(self)
        
        eventManager.getEventsFromServer()
        setDelegates()
        switchFilterVisibility()
        setupTableView()
        updateUI()
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
    
    func setupTableView() {
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        presentEventFromOverview()
    }
    
    func reloadTable() {
        arrayWithEvents = EventsList.getAllEventsWithType(eventsFilter.eventType, andStatus: eventsFilter.eventStatus)
        tableView.reloadData()
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func presentEventFromOverview() {

        if let event = eventToPresentFromOverview, doWePresentEventFromOverview {
            doWePresentEventFromOverview = false
            performSegue(withIdentifier: "ShowEventFromEventsList", sender: event)
        }
    }
    
    func updateUI() {
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        switchFilterVisibility()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let segueID = segue.identifier else { return }
        guard let destination = segue.destination as? EventDescVC else { return }
        guard let currentEvent = sender as? Event else { return }
        
        switch segueID {
        case "ShowEventFromEventsList":
            destination.currentEvent = currentEvent
        default:
            print("undefined segue")
            return
        }
    }
}

extension EventsListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayWithEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        cell.update(event: arrayWithEvents[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowEventFromEventsList", sender: arrayWithEvents[indexPath.row])
    }
}
