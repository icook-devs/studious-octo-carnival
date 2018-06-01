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
    var address: String = ""
    var address2: String?
    var city:String = ""
    var state:String = ""
    var zipCode:Int = 0
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    
    init(firstname:String, lastname:String,
         email:String, phone:String,
         address:String, address2:String,
         city:String, state:String,
         zipcode:Int, lat:Double, lon:Double) {
        self.firstName = firstname
        self.lastName = lastname
        self.email = email
        self.phone = phone
        self.address = address
        self.address2 = address2
        self.city = city
        self.state = state
        self.zipCode = zipcode
        self.latitude = lat
        self.longitude = lon
    }
}
