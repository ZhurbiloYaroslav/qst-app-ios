//
//  ArticleDescVC.swift
//  UREClub
//
//  Created by Yaroslav Zhurbilo on 20.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleDescVC: UIViewController {
    
    // MARK: IBOutlets of Event and News
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentWebView: UIWebView!
    @IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var slideshow: ImageSlideshow!
    
    var currentArticle: Event?
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        updateUIWithLocalizedText()
        setupImageSlider()
        updateUIWithValues()
    }
    
    func setDelegates() {
        contentWebView.delegate = self
    }
}

// MARK: Methods related with updating UI
extension ArticleDescVC {
    
    func updateUIWithLocalizedText() {
        
        navigationItem.title = ""
    }
    
    func updateUIWithValues() {

        guard let currentArticle = currentArticle else { return }
        
        setupSlideShowFor(currentArticle)
        
        titleLabel.text = currentArticle.title.uppercased()
        dateLabel.text = currentArticle.getStringWithDate()
        
        contentWebView.loadHTMLString(currentArticle.getHTMLContent(), baseURL: Bundle.main.bundleURL)
        contentWebView.scrollView.isScrollEnabled = true
        contentWebView.scrollView.bounces = true
        contentWebView.backgroundColor = UIColor.clear
        contentWebView.sizeToFit()
    }
}

// Methods related to WebView
extension ArticleDescVC: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.frame.size.height = 1
        webView.frame.size = webView.sizeThatFits(.zero)
        webView.scrollView.isScrollEnabled = false
        webViewHeightConstraint.constant = webView.scrollView.contentSize.height
        webView.scalesPageToFit = true
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.url, navigationType == UIWebViewNavigationType.linkClicked {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            return false
        }
        return true
    }
}

// Slider
extension ArticleDescVC {
    
    func setupImageSlider() {
        slideshow.backgroundColor = UIColor.clear
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.underScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        slideshow.pageControl.pageIndicatorTintColor = UIColor.black
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.currentPageChanged = { page in }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ArticleDescVC.didTap))
        slideshow.addGestureRecognizer(recognizer)
    }
    
    func setupSlideShowFor(_ event: Event) {
        
        var arrayWithImages = [SDWebImageSource]()
        
        if event.arrayWithImageLinks.count > 0 {
            for imageLink in event.arrayWithImageLinks {
                arrayWithImages.append(SDWebImageSource(urlString: imageLink)!)
            }
            slideshow.setImageInputs(arrayWithImages)
        } else {
            let imagePlaceholder = [ImageSource(imageString: "image-placeHolder")!]
            slideshow.setImageInputs(imagePlaceholder)
        }
    }
    
    @objc func didTap() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
        fullScreenController.closeButton.setImage(UIImage(named: "icon-close"), for: .normal)
    }
}
