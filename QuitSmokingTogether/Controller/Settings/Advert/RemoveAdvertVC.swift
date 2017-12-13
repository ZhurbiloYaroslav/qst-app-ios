//
//  RemoveAdvertVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 08.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import StoreKit

class RemoveAdvertVC: UIViewController {
    
    var products = [SKProduct]()
    
    var userDefaultsManager: UserDefaultsManager!
    
    @IBOutlet weak var messageTextLabel: UILabel!
    
    @IBOutlet weak var removeAdvertButton: UIButton!
    @IBOutlet weak var restorePurchasesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeVariables()
        
        setNObserverToHandlePurchaseNotification()
        
    }
    
    func initializeVariables() {
        userDefaultsManager = UserDefaultsManager()
        if userDefaultsManager.isProVersion {
            removeAdvertButton.isEnabled = false
            removeAdvertButton.setTitle("Is PRO", for: .normal)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reload()
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
