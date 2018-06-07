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
import FirebaseStorage

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
        
        ref.child(FirebaseTable.Seller).child(userID).child(FirebaseTable.Kitchen)
            .observeSingleEvent(of: .value) { (snapshot) in
                // Get user value
                if let data = snapshot.value as? NSDictionary {
                    NSLog("KitchenData: \(data)")
                    isAdded(true)
                } else {
                    isAdded(false) }
                // Get user value
                if let data = snapshot.value as? NSDictionary {
                    NSLog("KitchenData: \(data)")
                    isAdded(true)
                }
        }
    }
    
    class func uploadMedia(_ forChild:String, image:UIImage, completion: @escaping (_ url: String?) -> Void) {
        let storageRef = Storage.storage().reference().child("DishImages/\(forChild).png")
        if let uploadData = UIImagePNGRepresentation(image) {
            
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    //TODO: handle Error
                    print("error:\(error.debugDescription)")
                    completion(nil)
                } else {
                    
                    storageRef.downloadURL(completion: { (url, downLoadError) in
                        guard let downloadURL = url else {
                            //TODO: handle Error
                            // Uh-oh, an error occurred!
                            return
                        }
                        completion(downloadURL.absoluteString)
                    })
                }
            })
            
        }
    }
}
