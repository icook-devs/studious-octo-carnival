//
//  FirebaseUtil.swift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 6/6/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class FirebaseUtil: NSObject {

    class func loggedInUser() -> User {
        guard let user = Auth.auth().currentUser else {
            fatalError("Not logged in to app")
        }
        return user
    }
    class func loggedInUserUserID () -> String {
        guard let userID = Auth.auth().currentUser?.uid else {
            fatalError("Can't retrieve USER ID")
        }
        return userID
    }
    
    class func isKitchenAdded(isAdded: @escaping (Bool) -> () ) {
        let ref = Database.database().reference()
        let userID = loggedInUserUserID()
        //seller/{userID}/Kitchen
        ref.child(FirebaseTable.Seller).child(userID).child(FirebaseTable.Kitchen).observeSingleEvent(of: .value, 
                                                                                                      with: { (snapshot) in
            // Get user value
            if let data = snapshot.value as? NSDictionary {
                NSLog("KitchenData: \(data)")
                isAdded(true)
            }
        })

    }
}
