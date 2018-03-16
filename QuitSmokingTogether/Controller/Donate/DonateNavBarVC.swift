//
//  DonateNavBarVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 23.02.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class DonateNavBarVC: NavBarVC {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showDonateView()
    }
    
    private func showDonateView() {
        if let articleDescVC = ArticleDescVC.getInstance() {
            
            let donateFileName = getLocalizedDonateFileName()
            guard let path = Bundle.main.path(forResource: donateFileName, ofType: "html") else { return }
            let ngoHtmlText = try! String(contentsOfFile: path).trimmingCharacters(in: .whitespacesAndNewlines)
            
            let articleWithNGO = Event(id: 0, date: "",
                                       title: "", htmlContent: ngoHtmlText,
                                       type: [.Undefined], status: .All)
            guard let linkForNGOTitle = AssetExtractor.createLocalUrl(forImageNamed: "image-donate")
                else { return }
            let absoluteURL = linkForNGOTitle.absoluteString
            articleWithNGO.arrayWithImageLinks = [absoluteURL]
            articleDescVC.currentArticle = articleWithNGO
            navigationItem.title = "tabbar_donate".localized()
            //articleDescVC.title = "tabbar_donate".localized()
            self.pushViewController(articleDescVC, animated: true)
        }
    }
    
    private func getLocalizedDonateFileName() -> String {
        switch LanguageManager().currentLanguage {
        case .russian:
            return "Donate-ru"
        default:
            return "Donate-en"
        }
    }
    
}
