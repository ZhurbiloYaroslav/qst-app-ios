//
//  ShareVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 16.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import Social
import FBSDKShareKit
import FacebookShare
import GoogleMobileAds

class ShareVC: UIViewController {
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBanner()
    }
    
    @IBAction func shareWithFacebookButtonPressed(_ sender: UIButton) {
        chooseContentForSharingWith(.Facebook)
    }
    
    @IBAction func shareWithOtherAppsButtonPressed(_ sender: UIButton) {
        chooseContentForSharingWith(.ActivityVC)
    }
    
    func chooseContentForSharingWith(_ provider: ContentSharingProvider) {
        let alertController = UIAlertController(title: "Share", message: "Choose content for sharing", preferredStyle: .actionSheet)
        
        let actionShareApp = UIAlertAction(title: "Share this Application", style: .default) { (action) in
            self.shareWithProvider(provider, enumWithURL: .ThisApp)
        }
        actionShareApp.setValue(UIImage(named: "icon-app"), forKey: "image")
        let actionShareBook = UIAlertAction(title: "Share author's book", style: .default) { (action) in
            self.shareWithProvider(provider, enumWithURL: .Book)
        }
        actionShareBook.setValue(UIImage(named: "icon_book"), forKey: "image")
        let actionShareWebsite = UIAlertAction(title: "Share author's website", style: .default) { (action) in
            self.shareWithProvider(provider, enumWithURL: .Website)
        }
        actionShareWebsite.setValue(UIImage(named: "icon-website"), forKey: "image")
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(actionShareApp)
        alertController.addAction(actionShareBook)
        alertController.addAction(actionShareWebsite)
        alertController.addAction(actionCancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func shareWithProvider(_ provider: ContentSharingProvider, enumWithURL: URLForSharing) {
        let urlText = enumWithURL.rawValue
        let url = URL(string: urlText)!
        
        switch provider {
        case .Facebook:
            self.shareWithFacebook(url)
        case .ActivityVC:
            self.shareWithOtherApps(url)
        }
    }
    
    func shareWithFacebook(_ url: URL) {
        do {
            let shareContent = LinkShareContent(url: url)
            
            let shareDialog = ShareDialog(content: shareContent)
            shareDialog.mode = .shareSheet
            shareDialog.presentingViewController = self
            shareDialog.failsOnInvalidData = true
            shareDialog.completion = { result in
                switch result {
                case .success:
                    print("Share succeeded")
                case .failed:
                    print("Share failed")
                case .cancelled:
                    print("Share cancelled")
                }
            }
            try shareDialog.show()
        } catch {
            print("Error: \(error)")
        }
    }
    
    func shareWithOtherApps(_ url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        activityVC.completionWithItemsHandler = activityCompletionHandler
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func activityCompletionHandler(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) {
        if !completed {
            print("canceled share with other apps")
            return
        }
        print("User completed share with other apps")
    }
    
    func showAlert(service: String) {
        let alert = UIAlertController(title: "Error", message: "You are not connected to \(service)", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ShareVC {
    
    func setupBanner() {
        // Instantiate the banner view with your desired banner size.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.rootViewController = self
        // Set the ad unit ID to your own ad unit ID here.
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.load(GADRequest())
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        if #available(iOS 11.0, *) {
            // In iOS 11, we need to constrain the view to the safe area.
            positionBannerViewFullWidthAtBottomOfSafeArea(bannerView)
        }
        else {
            // In lower iOS versions, safe area is not available so we use
            // bottom layout guide and view edges.
            positionBannerViewFullWidthAtBottomOfView(bannerView)
        }
    }
    
    // MARK: - view positioning
    @available (iOS 11, *)
    func positionBannerViewFullWidthAtBottomOfSafeArea(_ bannerView: UIView) {
        // Position the banner. Stick it to the bottom of the Safe Area.
        // Make it constrained to the edges of the safe area.
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            guide.leftAnchor.constraint(equalTo: bannerView.leftAnchor),
            guide.rightAnchor.constraint(equalTo: bannerView.rightAnchor),
            guide.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor)
            ])
    }
    
    func positionBannerViewFullWidthAtBottomOfView(_ bannerView: UIView) {
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .leading,
                                              multiplier: 1,
                                              constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .trailing,
                                              multiplier: 1,
                                              constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: bottomLayoutGuide,
                                              attribute: .top,
                                              multiplier: 1,
                                              constant: 0))
    }
}

extension ShareVC {
    
    enum ContentSharingProvider: String {
        case Facebook = "Facebook"
        case ActivityVC = "Other apps"
    }
    
    enum URLForSharing: String {
        case ThisApp = "https://quitsmokingtogether.ru/ratingmovies.php"
        case Website = "http://quitsmokingtogether.org"
        case Book = "http://quitsmokingtogether.org/buy.php"
    }
    
}
