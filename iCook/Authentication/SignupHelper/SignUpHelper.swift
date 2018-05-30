//
//  SignUpHelper.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 5/30/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

class SignUpHelper: NSObject {

    class func isValidPassword(password: String) -> Bool {
        var result: Bool = true
//        if !password.isEmpty {
//            let passRegEx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z\\W_]{8,}$"
//            let passTest = NSPredicate(format: "SELF MATCHES %@", passRegEx)
//            result = passTest.evaluate(with: password)
//        }
        return result
    }
    
    class func isValidEmail(email: String) -> Bool {
        let validEmailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        if email.count == 0 {
            return false
        } else {
            do {
                let regEx = try NSRegularExpression(pattern: validEmailRegEx,
                                                    options: .caseInsensitive)
                return regEx.numberOfMatches(in: email,
                                             options: .anchored,
                                             range: NSMakeRange(0, email.count)) != 0
            } catch let error {
                print("Error: couldn't validate email: \(error)")
            }
            return false
        }
    }
}
