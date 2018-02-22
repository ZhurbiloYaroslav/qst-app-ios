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
    
    static let shared = AdMobManager()
    
    private var minutesHowOftenToShowAd: Int = 5
    private var lastDateWhenAdWasPresented: Date?
    
    func setLastDateWhenAdWasPresented() {
        lastDateWhenAdWasPresented = Date()
    }
    
    func doesAdWasShownMoreThanChosenPeriod() -> Bool {
        guard let lastDate = lastDateWhenAdWasPresented
            else { return true }
        let now = Date()
        var amountOfMinutes = lastDate.minutes(from: now)
        amountOfMinutes = abs(amountOfMinutes)
        return amountOfMinutes > minutesHowOftenToShowAd
    }
    
    func getFullScreenInterstitialForVC(_ viewController: UIViewController) {
        
        if AppPurchase().doWeShowAdvert(), doesAdWasShownMoreThanChosenPeriod() {
            let thisApp = UIApplication.shared.delegate as! AppDelegate
            thisApp.currentVcWithInterstitial = viewController
            thisApp.showAdmobInterstitial()
            
            setLastDateWhenAdWasPresented()
        }
        
    }
    
}

extension AdMobManager {
    
    enum AppID: String {
        case ThisAppID = "ca-app-pub-6005011458131199~8499863863"
        case TestAppID = "ca-app-pub-3940256099942544~1458002511"
    }
    
    enum BannerID: String {
        case Real_FullScreenBannerID = "ca-app-pub-6005011458131199/9625119569"
        case Test_InterstitialID = "ca-app-pub-3940256099942544/4411468910"
    }
}
