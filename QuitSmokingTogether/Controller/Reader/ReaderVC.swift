//
//  ReaderVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 12.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import FolioReaderKit
import GoogleMobileAds

class ReaderVC: UIViewController {
    
    let folioReader = FolioReader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        openFolioReader()
        folioReader.delegate = self
        folioReader.readerCenter?.delegate = self
        folioReader.readerCenter?.pageDelegate = self
    }
    
    @IBAction func goOutFromReader(_ sender: UIBarButtonItem) {
        AdMobManager().getFullScreenInterstitialForVC(self)
    }
    
    func openFolioReader() {
        let config = FolioReaderConfig()
        config.shouldHideNavigationOnTap = true
        config.enableTTS = false
        config.allowSharing = false
        config.useReaderMenuController = true
        let bookPath = Bundle.main.path(forResource: "QST-iBook", ofType: "epub")
        
        folioReader.currentFontSize = FolioReaderFontSize.xs
        folioReader.presentReader(parentViewController: self, withEpubPath: bookPath!, andConfig: config, shouldRemoveEpub: false)
    }
    
}

extension ReaderVC: FolioReaderDelegate, FolioReaderPageDelegate, FolioReaderCenterDelegate {
    
    func pageDidAppear(_ page: FolioReaderPage) {
        
        presentShareAlertIfDidNotSharedThisApp(page)
    }
    
    func presentShareAlertIfDidNotSharedThisApp(_ page: FolioReaderPage) {
        if page.pageNumber > 64 && CurrentUser.didUserShareThisApp == false {
            
            let alertController = UIAlertController(title: "Share", message: "Share it", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                self.folioReader.close()
            }))
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                let shareStoryboard = UIStoryboard(name: "Share", bundle: nil)
                if let shareVC = shareStoryboard.instantiateViewController(withIdentifier: "ShareVC") as? ShareVC {
                    shareVC.presentThisVcFromReader = true
                    self.folioReader.readerContainer?.present(shareVC, animated: true, completion: nil)
                }
            }))
            folioReader.readerContainer?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func folioReaderDidClose(_ folioReader: FolioReader) {
        tabBarController?.selectedIndex = 0
    }
}

extension ReaderVC: GADInterstitialDelegate {
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
//        tabBarController?.selectedIndex = 0
    }
}
