//
//  AuthenticationService.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 5/30/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class AuthenticationService: NSObject {
    class func signInUser(email: String, password:String, completion:@escaping (_ user: User?, _ error: Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                print("user created successfully")
                completion(user, nil)
            } else {
                completion(nil, error)
            }
        }
        
    }
    
    class func createUser(userData:UserInfo?,
                          password: String,
                          completion:@escaping (_ user: User?, _ error: Error?) -> Void) {
        
        guard let email = userData?.email else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil,
                let uObj = user{
                print("user created successfully")
                // once user created successfully, create userInfo table in FireBase DB
                addSellerInfoInFBDB(userInfo: userData!, user: uObj)
                completion(user, nil)
            } else {
                // TODO# handle error scenarios
                Util.showOkAlert(title: "Sign up failed", message: error?.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    class func resetPasswordWith(email:String, completion: @escaping (_ successfull: Bool) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                // send success
                completion(true)
            } else {
                // send fail
                completion(false)
            }
        }
    }
    
    private class func addSellerInfoInFBDB(userInfo:UserInfo, user:User) {
        
        // NOTE: please feel free to optimize it if necessary.
        let ref: DatabaseReference = Database.database().reference()
        let userId = user.uid
        let userData = ["First Name": userInfo.firstName,
                        "Last Name": userInfo.lastName,
                        "phone": userInfo.phone,
                        "email": userInfo.email,
                        "Address": userInfo.address,
                        "Address2": userInfo.address2,
                        "City": userInfo.city,
                        "State": userInfo.state,
                        "ZipCode": userInfo.zipCode,
                        "latitude": userInfo.latitude,
                        "Longitude": userInfo.longitude] as AnyObject
        ref.child(FirebaseTable.Seller).child(userId).child(FirebaseTable.UserInfo).setValue(userData)
    }
}
