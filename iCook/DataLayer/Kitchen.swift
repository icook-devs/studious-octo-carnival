//
//  Kitchen.swift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 6/5/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

class Kitchen: NSObject {
    var name: String = ""
    var food: String = ""
    var cusine: String = ""
    var timings: String = ""

    init(name: String, food: String, cusine: String, timings: String) {
        self.name = name
        self.food = food
        self.cusine = cusine
        self.timings = timings
    }

    init(kitchenDictory: [String: AnyObject]) {
        self.name = kitchenDictory["Kitchen"] as? String ?? ""
        self.food = kitchenDictory["Food"] as? String ?? ""
        self.cusine = kitchenDictory["Cuisine"] as? String ?? ""
        self.timings = kitchenDictory["Timings"] as? String ?? ""
    }
}
