//
//  Dish.swift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 6/5/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

class Dish: NSObject {
    var name: String = ""
    var style: String = ""
    var price: Float = 0.0
    var quantity: Int = 0

    init(name: String, style: String, price: Float, quantity: Int) {
        self.name = name
        self.style = style
        self.price = price
        self.quantity = quantity
    }

    init(dishDictory: [String: AnyObject]) {
        self.name = dishDictory["Name"] as? String ?? ""
        self.style = dishDictory["Style"] as? String ?? ""
        let price = dishDictory["Pricing"] as? String ?? "0.0"
        self.price = Float(price)!
        let quantity = dishDictory["Quantity"] as? String ?? "0"
        self.quantity = Int(quantity)!
    }

}
