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
        case Test_InterstitialBannerID = "ca-app-pub-3940256099942544/4411468910"
    }
    
    //TODO: appcoda.com/google-admob-ios-swift/
    
    func getFullScreenBannerFor(viewController: UIViewController, bannerView: GADBannerView) {
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID, "e9ebcd52a35476ac486fdfb4a9c6567a57c1b88c"]
        
        bannerView.adSize = kGADAdSizeFluid
        bannerView.adUnitID = BannerID.Test_InterstitialBannerID.rawValue
        bannerView.delegate = viewController as? GADBannerViewDelegate
        bannerView.rootViewController = viewController
        bannerView.load(request)
        
    }
    
    //    func getFullScreenBannerFor(viewController: UIViewController, adBannerView: GADBannerView) {
    //
    //        let request = GADRequest()
    //        request.testDevices = [kGADSimulatorID, "e9ebcd52a35476ac486fdfb4a9c6567a57c1b88c"]
    //
    //        adBannerView.adUnitID = BannerID.Test_InterstitialBannerID.rawValue
    //        adBannerView.delegate = viewController as? GADBannerViewDelegate
    //        adBannerView.rootViewController = viewController
    //        adBannerView.load(request)
    //
    //    }
    
}

