//
//  Constants.swift
//  PharmacyMobileCheckIn
//
//  Created by Sambasiva Rao Dodigam on 3/7/17.
//  Copyright © 2017 Kaiser Permanente. All rights reserved.
//

import UIKit

// Storyboard name
enum Storyboard: String {
    case main                       = "Main"
    case kitchen                    = "Kitchen"
    case addDish                    = "AddDish"
    case sellerHome                 = "SellerHome"
}

// Storyboard viewController identifier
enum StoryboardID: String {
    case signInVC                   = "SignInStoryboardID"
    case kitchenNavVC               = "KitchenNavVC"
    case addDishNavVC               = "AddDishNavVC"
    case sellerHomeViewController   = "SellerHomeViewController"
}

// UserDefaults
// String enum values can be omitted when they are equal to the enumcase name
enum UserDefaultsKey: String {
    case isKitchenAdded
}
