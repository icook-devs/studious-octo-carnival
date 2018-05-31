//
//  UserInfo.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 5/30/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phone: String = ""
    
    init(firstname:String, lastname:String, email:String, phone:String) {
        self.firstName = firstname
        self.lastName = lastname
        self.email = email
        self.phone = phone
    }
}
