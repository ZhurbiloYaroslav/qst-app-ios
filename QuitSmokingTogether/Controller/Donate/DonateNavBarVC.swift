//
//  DonateNavBarVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 23.02.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class DonateNavBarVC: NavBarVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showDonateView()
    }
    
    func showDonateView() {
        if let articleDescVC = ArticleDescVC.getInstance() {
            
            guard let path = Bundle.main.path(forResource: "Donate", ofType: "html") else { return }
            let ngoHtmlText = try! String(contentsOfFile: path).trimmingCharacters(in: .whitespacesAndNewlines)
            
            let articleWithNGO = Event(id: 0, date: "",
                                       title: "", htmlContent: ngoHtmlText,
                                       type: [.Undefined], status: .All)
            guard let linkForNGOTitle = AssetExtractor.createLocalUrl(forImageNamed: "image-donate")
                else { return }
            let absoluteURL = linkForNGOTitle.absoluteString
            articleWithNGO.arrayWithImageLinks = [absoluteURL]
            articleDescVC.currentArticle = articleWithNGO
            self.pushViewController(articleDescVC, animated: true)
        }
    }
    
}
