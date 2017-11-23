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
    
    let eventsList: [Event] = [
        Event(title: "\"Quit Smoking Together\" action was held in Kyiv",
              text: "The activists dressed as branded cigarettes handed out CDs with Alexey Koval's book \"Quit Smoking Together\". The photos show how it all went :) ",
              images: [
                "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8571.JPG",
                "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8562.JPG",
                "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8560.JPG",
                "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8546.JPG",
                "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8543.JPG"
                ]
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegates()
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
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
}
