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

    init(userInfoDict: [String: AnyObject]) {
        self.firstName = userInfoDict["First Name"] as? String ?? ""
        self.lastName = userInfoDict["Last Name"] as? String ?? ""
        self.email = userInfoDict["email"] as? String ?? ""
        self.phone = userInfoDict["phone"] as? String ?? ""
        self.address = userInfoDict["Address"] as? String ?? ""
        self.address2 = userInfoDict["Address2"] as? String ?? ""
        self.city = userInfoDict["City"] as? String ?? ""
        self.state = userInfoDict["State"] as? String ?? ""
        let zipCode = userInfoDict["ZipCode"] as? Int ?? 0
        self.zipCode = zipCode
    }

    func getFullName() -> String {
        var fullName = ""
        if firstName.isEmpty == false &&
            lastName.isEmpty == false {
            fullName.append(firstName)
            fullName.append(" ")
            fullName.append(lastName)
        }
        return fullName
    }
    func getCityStateZip() -> String {
        var addressLine2 = ""
        if city.isEmpty == false &&
            state.isEmpty == false &&
            zipCode != 0 {
            addressLine2.append(city)
            addressLine2.append(" ")
            addressLine2.append(state)
            addressLine2.append(" ")
            addressLine2.append(String(zipCode))
            return addressLine2
        }

        if city.isEmpty == false &&
            state.isEmpty == false {
            addressLine2.append(city)
            addressLine2.append(" ")
            addressLine2.append(state)
            return addressLine2
        }
        return addressLine2
    }
}
