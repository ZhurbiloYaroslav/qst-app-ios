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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegates()
        filterVisibility()
        updateUI()
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateUI() {
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        filterVisibility()
    }
    
    func filterVisibility() {
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
