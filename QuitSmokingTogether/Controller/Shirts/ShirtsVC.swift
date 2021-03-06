//
//  ShirtsVC.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 22.02.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class ShirtsVC: UIViewController {
    
    @IBOutlet var slideshow: ImageSlideshow!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet weak var donateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUIWithLocalizedText()
        setupImageSlider()
        donateButton.setRadius(10, withWidth: 1, andColor: UIColor.clear)
    }
    
    func updateUIWithLocalizedText() {
        
        navigationItem.title = "shirts_screen_title".localized()
        titleTextLabel.text = "shirts_text_title".localized()
        messageTextLabel.text = "shirts_text_message".localized()
        donateButton.setTitle("button_donate".localized(), for: .normal)
    }
    
    @IBAction func donateButtonPressed(_ sender: UIButton) {
        tabBarController?.selectedIndex = 3
//        if let donateVC = DonateVC.getInstance() {
//            navigationController?.pushViewController(donateVC, animated: true)
//        }
    }
    
}

// Slider
extension ShirtsVC {
    
    func setupImageSlider() {
        slideshow.backgroundColor = UIColor.clear
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.insideScrollView
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
            ImageSource(imageString: "image-shirt-1"),
            ImageSource(imageString: "image-shirt-2"),
            ImageSource(imageString: "image-shirt-3"),
            ImageSource(imageString: "image-shirt-4"),
            ImageSource(imageString: "image-shirt-5"),
            ImageSource(imageString: "image-shirt-6"),
            ImageSource(imageString: "image-shirt-7"),
            ImageSource(imageString: "image-shirt-8"),
            ImageSource(imageString: "image-shirt-9"),
            ImageSource(imageString: "image-shirt-10"),
            ImageSource(imageString: "image-shirt-11"),
            ImageSource(imageString: "image-shirt-12"),
            ImageSource(imageString: "image-shirt-13")
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
