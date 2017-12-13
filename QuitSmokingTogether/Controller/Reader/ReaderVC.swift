//
//  ReaderVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 12.10.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import FolioReaderKit

class ReaderVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        openFolioReader()
    }
    
    @IBAction func goOutFromReader(_ sender: UIBarButtonItem) {
        tabBarController?.selectedIndex = 0
    }
    
    func openFolioReader() {
        let config = FolioReaderConfig()
        config.shouldHideNavigationOnTap = true
        config.enableTTS = false
        let bookPath = Bundle.main.path(forResource: "QST-iBook", ofType: "epub")
        let folioReader = FolioReader()
        folioReader.delegate = self
        folioReader.currentFontSize = FolioReaderFontSize.xs
        folioReader.presentReader(parentViewController: self, withEpubPath: bookPath!, andConfig: config, shouldRemoveEpub: false)
    }
    
}

extension ReaderVC: FolioReaderDelegate, FolioReaderPageDelegate, FolioReaderCenterDelegate {
    func folioReaderDidClose(_ folioReader: FolioReader) {
        tabBarController?.selectedIndex = 0
    }
}
