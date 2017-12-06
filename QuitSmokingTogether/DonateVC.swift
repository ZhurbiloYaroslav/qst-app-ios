//
//  DonateVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 21.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class DonateVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func appStoreButtonPressed(_ sender: UIButton) {
        print("pressed")
        Browser.openURLWith(.AppInItunes)
    }
    
    @IBAction func buttonWithVisa6985Pressed(_ sender: UIButton) {
        shareWithOtherApps()
    }
    
    func shareWithOtherApps() {
        let activityVC = UIActivityViewController(activityItems: ["4627 0551 2505 6985"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        activityVC.completionWithItemsHandler = activityCompletionHandler
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func activityCompletionHandler(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) {
        if !completed {
            Alert().presentAlertWith(title: "Donation", andMessages: ["Thanks for interest!"]) { (alertController) in
                self.present(alertController, animated: true, completion: nil)
            }
            return
        }
        Alert().presentAlertWith(title: "Donation", andMessages: ["Thanks for donation!"]) { (alertController) in
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
