//
//  UIScrollView+scrollToView.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 13.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

extension UIScrollView {
    
//    // Scroll to a specific view so that it's top is at the top our scrollview
//    func scrollToView(view:UIView, animated: Bool) {
//        if let origin = view.superview {
//            // Get the Y position of your child view
//            let childStartPoint = origin.convert(view.frame.origin, to: self)
//            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
//            self.scrollRectToVisible(CGRectMake(0, childStartPoint.y, 1, self.frame.height), animated: animated)
//        }
//    }
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
}
