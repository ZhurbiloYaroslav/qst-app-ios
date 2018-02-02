//
//  RemoveAdvertVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 08.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import StoreKit

extension RemoveAdvertVC: StoryboardInitialized {}

class RemoveAdvertVC: UIViewController {
    
    var products = [SKProduct]()
    
    var userDefaultsManager: UserDefaultsManager!
    
    @IBOutlet var slideshow: ImageSlideshow!
    
    @IBOutlet weak var messageTextLabel: UILabel!
    
    @IBOutlet weak var removeAdvertButton: UIButton!
    @IBOutlet weak var restorePurchasesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeVariables()
        
        setNObserverToHandlePurchaseNotification()
        updateUIWithLocalizedText()
        setupImageSlider()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reload()
    }
    
    func initializeVariables() {
        userDefaultsManager = UserDefaultsManager()
        if userDefaultsManager.isProVersion {
            removeAdvertButton.isEnabled = false
            removeAdvertButton.setTitle("Is PRO", for: .normal)
        }
        
    }
    
    func updateUIWithLocalizedText() {
        messageTextLabel.text = "advert_remove_text_message".localized()
    }
    
    func reload() {
        products = []
        
        self.view.setNeedsDisplay()
        
        AppProducts.store.requestProducts{success, products in
            
            if success {
                self.products = products!
                
                self.view.setNeedsDisplay()
            }
            
        }
    }
    
    @objc func handlePurchaseNotification(_ notification: Notification) {
        guard let productID = notification.object as? String else { return }
        
        for product in products {
            guard product.productIdentifier == productID else {
                continue
            }
            
            self.enableProFunctions()
        }
    }
    
    func switchPro() {
        
//        removeAdIfPRO()
        restorePurchasesButton.isEnabled = false
        
    }
    
    func enableProFunctions() {
        
        removeAdvertButton.setTitle("IS PRO", for: .normal)
        
        if userDefaultsManager.isProVersion {

            self.switchPro()
            self.view.setNeedsDisplay()

        }
        
    }
    
    func setNObserverToHandlePurchaseNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(RemoveAdvertVC.handlePurchaseNotification(_:)),
                                               name: NSNotification.Name(rawValue: IAPHelper.IAPHelperPurchaseNotification),
                                               object: nil)
    }
    
}

// Slider
extension RemoveAdvertVC {
    
    func setupImageSlider() {
        slideshow.backgroundColor = UIColor.clear
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.underScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        slideshow.pageControl.pageIndicatorTintColor = UIColor.black
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.currentPageChanged = { page in }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(RemoveAdvertVC.didTap))
        slideshow.addGestureRecognizer(recognizer)
        
        setupSlideShow()
    }
    
    func setupSlideShow() {
        
        var arrayWithImageSource = [ImageSource]()
        let arrayWithLocalImages = [
            ImageSource(imageString: "dsc06256"),
            ImageSource(imageString: "dsc06257")
        ]
        for imageSource in arrayWithLocalImages {
            if let imageSource = imageSource {
                arrayWithImageSource.append(imageSource)
            }
        }
        
        slideshow.setImageInputs(arrayWithImageSource)
    }
    
    @objc func didTap() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
        fullScreenController.closeButton.setImage(UIImage(named: "icon-close"), for: .normal)
    }
}

extension RemoveAdvertVC {
    
    @IBAction func removeAdvertButtonPressed(_ sender: UIButton) {
        for product in products {
            let prodID = product.productIdentifier
            if(prodID == AppProducts.BuyProProductID) {
                
                AppProducts.store.buyProduct(product)
            }
        }
    }
    
    @IBAction func restorePurchasesButtonPressed(_ sender: UIButton) {
        AppProducts.store.restorePurchases()
    }
    
}

//MARK: Methods That related to Store Kit
extension RemoveAdvertVC: SKPaymentTransactionObserver {
    
    func makePurchaseAndRestoreButtons(state: ButtonState) {
        
        var isEnabled = true
        
        if state == .Disabled {
            isEnabled = false
        }
        
        removeAdvertButton.isUserInteractionEnabled = isEnabled
        restorePurchasesButton.isUserInteractionEnabled = isEnabled
        
    }
    
    enum ButtonState {
        case Enabled
        case Disabled
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction
            let productID = t.payment.productIdentifier
            
            switch productID {
            case AppProducts.BuyProProductID:
                
                enableProFunctions()
                
            default:
                print("IAP not found")
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction: AnyObject in transactions {
            
            if let trans = transaction as? SKPaymentTransaction {
                
                switch trans.transactionState {
                case .purchased:
                    
                    switch products[0].productIdentifier {
                    case AppProducts.BuyProProductID:
                        
                        enableProFunctions()
                        
                    default:
                        break
                        // "IAP not found"
                    }
                    
                    // Finish currecn transaction
                    queue.finishTransaction(trans)
                case .failed:
                    
                    print("Buy error")
                    // Finish current transaction
                    queue.finishTransaction(trans)
                    break
                default:
                    print("Default")
                    break
                }
            }
            
        }
    }
    
}
