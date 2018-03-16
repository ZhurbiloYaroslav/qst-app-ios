//
//  ShareVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 16.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import Social
import FBSDKCoreKit
import FBSDKShareKit
//import FacebookShare

class ShareVC: UIViewController {
    
    @IBOutlet weak var shareTextMessage: UILabel!
    @IBOutlet weak var shareButtonsStack: UIStackView!
    
    var presentThisVcFromReader: Bool?
    
    var currentAlertController: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUIWithLocalizedText()
        
    }
    
    func updateUIWithLocalizedText() {
        navigationItem.title = "share_screen_title".localized()
        shareTextMessage.text = "share_text_message".localized()
    }
    
    @IBAction func shareWithFacebookButtonPressed(_ sender: UIButton) {
        chooseContentForSharingWith(.Facebook)
    }
    
    @IBAction func shareWithOtherAppsButtonPressed(_ sender: UIButton) {
        chooseContentForSharingWith(.ActivityVC)
    }
    
}


// MARK: Supporting methods and values
extension ShareVC {
    
    var doWeNeedToDismissCurrentScreen: Bool {
        let doesWeCameFromReaderScreen = presentThisVcFromReader ?? false
        return doesWeCameFromReaderScreen
    }
    
    func dismissScreenIfNeeded() {
        if doWeNeedToDismissCurrentScreen {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

// Sharing related Methods and Entities
extension ShareVC {
    
    func chooseContentForSharingWith(_ provider: ContentSharingProvider) {
        
        let shareTitle = "alert_share_title".localized()
        let shareMessage = "alert_share_message".localized()
        let alertController = UIAlertController(title: shareTitle, message: shareMessage, preferredStyle: .actionSheet)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = shareButtonsStack
            popoverController.sourceRect = CGRect(x: shareButtonsStack.bounds.midX, y: shareButtonsStack.bounds.origin.y, width: 0, height: 0)
            popoverController.permittedArrowDirections = [.down]
        }
        
        addActionsTo(alertController, withProvider: provider)
        
        currentAlertController = alertController
        self.present(alertController, animated: true) {
            alertController.view.superview?.isUserInteractionEnabled = true
            alertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        }
    }
    
    @objc func alertControllerBackgroundTapped(){
        dismissScreenIfNeeded()
    }
    
    func addActionsTo(_ alertController: UIAlertController, withProvider provider: ContentSharingProvider) {
        
        let shareAppText = "share_app_text".localized()
        let shareAppAction = UIAlertAction(title: shareAppText, style: .default) { (action) in
            self.shareWithProvider(provider, enumWithURL: .ThisApp)
        }
        shareAppAction.setValue(UIImage(named: "icon-app"), forKey: "image")
        
        let shareBookText = "share_book_text".localized()
        let shareBookAction = UIAlertAction(title: shareBookText, style: .default) { (action) in
            self.shareWithProvider(provider, enumWithURL: .Book)
        }
        shareBookAction.setValue(UIImage(named: "icon_book"), forKey: "image")
        
        let shareWebsiteText = "share_website_text".localized()
        let shareWebsiteAction = UIAlertAction(title: shareWebsiteText, style: .default) { (action) in
            self.shareWithProvider(provider, enumWithURL: .Website)
        }
        shareWebsiteAction.setValue(UIImage(named: "icon-website"), forKey: "image")
        
        let cencelActionText = "button_cancel".localized()
        let actionCancel = UIAlertAction(title: cencelActionText, style: .cancel) { (action) in
            self.dismissScreenIfNeeded()
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

        let shareContent = FBSDKShareLinkContent()
        shareContent.contentURL = url

        let shareDialog = FBSDKShareDialog()
        shareDialog.fromViewController = self
        shareDialog.shareContent = shareContent
        shareDialog.delegate = self
        
        if let url = URL(string: "fbauth2://"), (UIApplication.shared.canOpenURL(url)) {
            shareDialog.mode = FBSDKShareDialogMode.shareSheet
        } else {
            shareDialog.mode = FBSDKShareDialogMode.feedBrowser
        }
        
        shareDialog.show()
    }
    
    func shareWithOtherApps(_ url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = shareButtonsStack
            popoverController.sourceRect = CGRect(x: shareButtonsStack.bounds.midX, y: shareButtonsStack.bounds.origin.y, width: 0, height: 0)
            popoverController.permittedArrowDirections = [.down]
        }
        
        activityVC.completionWithItemsHandler = activityCompletionHandler
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func activityCompletionHandler(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) {
        if !completed {
            dismissScreenIfNeeded()
            return
        }
        CurrentUser.didUserShareThisApp = true
        dismissScreenIfNeeded()
    }
    
    func showAlert(service: String) {
        let errorTitle = "alert_share_error_title".localized()
        let errorMessage = "alert_share_error_message".localized()
        let alert = UIAlertController(title: errorTitle, message: "\(errorMessage) \(service)", preferredStyle: .alert)
        let dismissText = "button_dismiss".localized()
        let dismissAction = UIAlertAction(title: dismissText, style: .cancel, handler: nil)
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

extension ShareVC: FBSDKSharingDelegate {
    
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        CurrentUser.didUserShareThisApp = true
        dismissScreenIfNeeded()
    }
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {

    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
        dismissScreenIfNeeded()
    }
    
    
}
