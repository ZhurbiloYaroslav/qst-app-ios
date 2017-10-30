////
////  HideKeyboard.swift
////  QuitSmokingTogether
////
////  Created by Yaroslav Zhurbilo on 29.10.17.
////  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
////
//
//import UIKit
//import Foundation
//
//protocol HideKeyboard {
//    var activeTextField: UITextField {get set}
//    var textFields: [UITextField] {get set}
//}
//
//extension HideKeyboard: UITextFieldDelegate where Self: UIViewController {
//    // Tutorial Move textfield up when Keyboard appears https://www.youtube.com/watch?v=AiYCStoj0lc
//    
//    mutating func textFieldDidBeginEditing(_ textField: UITextField) {
//        activeTextField = textField
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        for tField in textFields {
//            tField.resignFirstResponder()
//        }
//        
//        return true
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//    
//    func registerForKeyboardNotifications() {
//        
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillShow),
//                                               name: NSNotification.Name.UIKeyboardWillShow,
//                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillHide),
//                                               name: NSNotification.Name.UIKeyboardWillHide,
//                                               object: nil)
//    }
//    
//    @objc func keyboardWillShow(_ notification: Notification) {
//        let userInfo = notification.userInfo
//        guard let keyboardFrameSize = (userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
//            else { return }
//        let keyboardY = self.view.frame.size.height - keyboardFrameSize.height
//        let editingTextFieldY = activeTextField.convert(activeTextField.bounds.origin, to: nil).y
//        
//        if editingTextFieldY > keyboardY - 60 {
//            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
//                self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY - (keyboardY - 60)),
//                                         width: self.view.bounds.width, height: self.view.bounds.height)
//            }, completion: nil)
//        }
//    }
//    
//    @objc func keyboardWillHide(_ notification: Notification) {
//        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
//            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
//        }, completion: nil)
//    }
//    
//    func removeKeyboardNotifications() {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//    }
//}

