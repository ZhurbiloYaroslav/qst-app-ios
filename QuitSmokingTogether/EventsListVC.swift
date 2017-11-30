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
    
    let eventsList: [Event] = EventsList.getArrayWithEvents()
    
    var eventToPresentFromOverview: Event?
    var doWePresentEventFromOverview = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegates()
        switchFilterVisibility()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presentEventFromOverview()
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
        print("Start prepare for segue")
        guard let segueID = segue.identifier else { return }
        guard let destination = segue.destination as? EventVC else { return }
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
        return eventsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventInListCell", for: indexPath) as! EventCell
        cell.update(event: eventsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowEventFromEventsList", sender: eventsList[indexPath.row])
    }
}
