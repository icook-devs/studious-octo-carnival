//
//  UIApplication+Extension.swift
//  PharmacyMobileCheckIn
//
//  Created by Philip M. Bacchi on 5/24/17.
//  Based on Stack Overflow 
//  https://stackoverflow.com/questions/26667009/get-top-most-uiviewcontroller
//  Copyright © 2017 Kaiser Permanente. All rights reserved.
//

import UIKit

extension UIApplication {
    class func topViewController() -> UIViewController? {

        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            // topController should now be your topmost view controller
            return topController
        }
        return UIApplication.shared.keyWindow?.rootViewController
    }
}
