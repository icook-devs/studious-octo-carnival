//
//  Util.swift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 5/29/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit
import Firebase

class Util: NSObject {
    
    class func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    class func loggedInAsBuyyer() -> Bool {
        return appDelegate().loggedInAsBuyyer
    }
}
