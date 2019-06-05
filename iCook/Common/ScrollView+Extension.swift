//
//  ScrollView+Extension.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 5/30/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    
    func registerKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

    }
    
    func deRegisterKeyboard() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)

    }
    
    @objc
    func keyboardWasShown(notification: NSNotification) {
        self.isScrollEnabled = true
        var info = notification.userInfo
        let keyboardSize = (info![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: (keyboardSize?.height)!, right: 0.0)
        self.contentInset = contentInsets
        self.scrollIndicatorInsets = contentInsets
    }
    
    @objc
    func keyboardWillBeHidden(notification: NSNotification) {
        var info = notification.userInfo
        let keyboardSize = (info![UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: self.contentInset.bottom-keyboardSize!.height, right: 0.0)
        self.contentInset = contentInsets
        self.scrollIndicatorInsets = contentInsets
    }
}
