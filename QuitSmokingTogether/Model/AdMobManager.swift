//
//  AdMobManager.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 08.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import GoogleMobileAds

class AdMobManager {
    
    enum AppID: String {
        case ThisAppID = "ca-app-pub-6005011458131199~8499863863"
        case TestAppID = "ca-app-pub-3940256099942544~1458002511"
    }
    
    enum BannerID: String {
        case Real_FullScreenBannerID = "ca-app-pub-6005011458131199/9625119569"
        case Test_InterstitialID = "ca-app-pub-3940256099942544/4411468910"
    }
    
    func getFullScreenInterstitialForVC(_ viewController: UIViewController) {
        
        if AppPurchase().doWeShowAdvert() {
            let thisApp = UIApplication.shared.delegate as! AppDelegate
            thisApp.currentVcWithInterstitial = viewController
            thisApp.showAdmobInterstitial()
        }
        
    }
    
}
