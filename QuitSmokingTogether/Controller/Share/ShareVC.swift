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

class ShareVC: UIViewController {
    
    @IBOutlet weak var shareTextMessage: UILabel!
    @IBOutlet weak var shareButtonsStack: UIStackView!
    
    var presentThisVcFromReader: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUIWithLocalizedText()
        
    }
    
    func updateUIWithLocalizedText() {
        shareTextMessage.text = "share_text_message".localized()
    }
    
    @IBAction func shareWithFacebookButtonPressed(_ sender: UIButton) {
        chooseContentForSharingWith(.Facebook)
    }
    
    @IBAction func shareWithOtherAppsButtonPressed(_ sender: UIButton) {
        chooseContentForSharingWith(.ActivityVC)
    }
    
}

// Sharing related Methods and Entities
extension ShareVC {
    
    func chooseContentForSharingWith(_ provider: ContentSharingProvider) {
        
        let alertController = UIAlertController(title: "Share", message: "Choose content for sharing", preferredStyle: .actionSheet)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = shareButtonsStack
            popoverController.sourceRect = CGRect(x: shareButtonsStack.bounds.midX, y: shareButtonsStack.bounds.origin.y, width: 0, height: 0)
            popoverController.permittedArrowDirections = [.down]
        }
        
        addActionsTo(alertController, withProvider: provider)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addActionsTo(_ alertController: UIAlertController, withProvider provider: ContentSharingProvider) {
        
        let shareAppAction = UIAlertAction(title: "Share this Application", style: .default) { (action) in
            self.shareWithProvider(provider, enumWithURL: .ThisApp)
        }
        shareAppAction.setValue(UIImage(named: "icon-app"), forKey: "image")
        
        let shareBookAction = UIAlertAction(title: "Share author's book", style: .default) { (action) in
            self.shareWithProvider(provider, enumWithURL: .Book)
        }
        shareBookAction.setValue(UIImage(named: "icon_book"), forKey: "image")
        
        let shareWebsiteAction = UIAlertAction(title: "Share author's website", style: .default) { (action) in
            self.shareWithProvider(provider, enumWithURL: .Website)
        }
        shareWebsiteAction.setValue(UIImage(named: "icon-website"), forKey: "image")
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(shareAppAction)
        alertController.addAction(shareBookAction)
        alertController.addAction(shareWebsiteAction)
        alertController.addAction(actionCancel)
        
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
                    CurrentUser.didUserShareThisApp = true
                    self.dismiss(animated: true, completion: nil)
                case .failed:
                    print("Share failed")
                case .cancelled:
                    self.dismiss(animated: true, completion: nil)
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
            self.dismiss(animated: true, completion: nil)
            print("canceled share with other apps")
            return
        }
        CurrentUser.didUserShareThisApp = true
        self.dismiss(animated: true, completion: nil)
        print("User completed share with other apps")
    }
    
    func showAlert(service: String) {
        let alert = UIAlertController(title: "Error", message: "You are not connected to \(service)", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    enum ContentSharingProvider: String {
        case Facebook = "Facebook"
        case ActivityVC = "Other apps"
    }
    
    enum URLForSharing: String {
        case ThisApp = "https://quitsmokingtogether.org/ratingmovies.php"
        case Website = "http://quitsmokingtogether.org"
        case Book = "http://quitsmokingtogether.org/buy.php"
    }
    
}
