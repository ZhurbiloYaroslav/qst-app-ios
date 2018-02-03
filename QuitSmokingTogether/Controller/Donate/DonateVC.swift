//
//  DonateVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 21.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import UserNotifications

class DonateVC: UITableViewController {
    
    @IBOutlet weak var paymentPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
    }
    
    func setDelegates() {
        paymentPicker.delegate = self
        paymentPicker.dataSource = self
    }
    
    @IBAction func donateButtonPressed(_ sender: UIButton) {
        Browser.openURLWith(.Donate_100_UAH)
    }
    
}

extension DonateVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 5
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch (component, row) {
        case (0,0):
            return "20"
        case (0,1):
            return "50"
        case (0,2):
            return "100"
        case (1,0):
            return "UAH"
        case (1,1):
            return "USD"
        case (1,2):
            return "EUR"
        default:
            return nil
        }
    }
}
