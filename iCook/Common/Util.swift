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

    class func loggedInUser() -> User {
        guard let user = appDelegate().user else {
            fatalError("Not logged in to app")
        }
        return user
    }
    class func loggedInUserUserID() -> String {
        guard let user = appDelegate().user else {
            fatalError("Not logged in to app")
        }
        return user.uid
    }
}
