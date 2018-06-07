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

    //MARK: - Dish Utlitiy methods
    class func getSellersForBuyyer(sellers: @escaping ([Seller]) -> ()) {
        var sellersArray = [Seller]()
        let ref = Database.database().reference()
        let _ = ref.observe(.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            if let sellersFireBaseArray = postDict[FirebaseTable.Seller] as? [String : AnyObject] {
                for seller in sellersFireBaseArray.values {
                    let sellerModel = Seller()
                    if let sellerObject = seller as? [String: AnyObject] {
                        if let kitchenDict = sellerObject[FirebaseTable.Kitchen] as? [String: AnyObject] {
                            sellerModel.kitchen = Kitchen(kitchenDictory: kitchenDict)
                        }
                        if let userInfoDict = sellerObject[FirebaseTable.UserInfo] as? [String: AnyObject] {
                            sellerModel.userInfo = UserInfo(userInfoDict: userInfoDict)
                        }
                        if let dishes = sellerObject[FirebaseTable.Dish] as? [String : AnyObject] {
                            var disheModels = [Dish]()
                            for (key, value) in dishes {
                                if let dishDict = value as? [String: AnyObject] {
                                    let dishModel = Dish(dishDictory: dishDict as [String : AnyObject],
                                                         dishID: key)
                                    disheModels.append(dishModel)
                                }
                            }
                            sellerModel.dishes = disheModels
                        }
                        sellersArray.append(sellerModel)
                    }
                }
                NSLog("\(sellersArray)")
                sellers(sellersArray)
            }
        })
    }
}
