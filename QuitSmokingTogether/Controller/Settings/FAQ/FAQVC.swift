//
//  FAQVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 16.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class FAQVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let faq = FAQ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        addContentInsets()
        
        AdMobManager().getFullScreenInterstitialForVC(self)
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FaqShowAnswer" {
            guard let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            if let destination = segue.destination as? FAQAnswerVC {
                destination.faqItem = faq.getItemForIndexPath(indexPath)
            }
        }
    }
}

extension FAQVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return faq.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return faq.numberOfItemsInSection(section)
    }
    
    var headerHeight: CGFloat {
        return 30
    }
    var footerHeight: CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell", for: indexPath) as! FAQCell
        
        let faqItem = faq.getItemForIndexPath(indexPath)
        cell.update(item: faqItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return faq.getSectionWithIndex(section).name
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: headerHeight))
        let label = makeLabelForHeaderWith(section)
        headerView.addSubview(label)
        headerView.backgroundColor = Constants.Color.green

        return headerView
    }
    
    func makeLabelForHeaderWith(_ section: Int) -> UILabel {
        
        let headerLabel = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width - 20, height: 18))
        headerLabel.textColor = UIColor.white
        headerLabel.text = faq.getSectionWithIndex(section).name
        
        return headerLabel
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: footerHeight))
        if section < (tableView.numberOfSections - 1) {
            footerView.backgroundColor = Constants.Color.green
        } else {
            footerView.backgroundColor = UIColor.clear
        }
        
        return footerView
    }
    
    func addContentInsets() {
        self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0)
    }
}
