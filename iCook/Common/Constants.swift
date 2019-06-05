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
    case buyyerHome                 = "BuyyerHome"
    case home                       = "Home"
    case buyyerDishDetail           = "BuyyerDishDetail"
    case buyyerSelectedDishes       = "BuyyerSelectedDishes"
    case filterDishes               = "FilterDishes"
}

// Storyboard viewController identifier
enum StoryboardID: String {
    case signInVC                   = "SignInStoryboardID"
    case kitchenNavVC               = "KitchenNavVC"
    case addDishNavVC               = "AddDishNavVC"
    case sellerHomeViewController   = "SellerHomeViewController"
    case sellerHomeNavVC            = "sellerHomeNavVC"
    case buyyerHomeNavVC            = "BuyyerHomeNavVC"
    case homeViewController         = "HomeViewController"
    case buyyerDishDetailVC         = "BuyyerDishDetailViewController"
    case buyyerSelectedDishesVC     = "BuyyerSelectedDishesViewController"
    case filterDishesNavVC          = "FilterDishesNavVC"
}

// MARK: Menu View Constants
struct MenuView {
    static let homeTitle           = "Home"
    static let sellerHomeSBId      = "SellerHomeViewController"
    static let buyerHomeSBId      = "BuyyerHomeViewController"
    static let kitchenTitle        = "My Kitchen"
    static let historyTitle        = "History"
    static let directorySBId       = "DirectoryViewController"
    static let profileTtile        = "Profile"
    static let ordersTitle         = "Orders"
    static let archiveSBId         = "HistoryViewController"
    static let signoutTitle        = "Sign Out"
}

// UserDefaults
// String enum values can be omitted when they are equal to the enumcase name
enum UserDefaultsKey: String {
    case isKitchenAdded
}

struct FirebaseTable {
    static let Seller = "Seller"
    static let Buyyer = "Buyyer"
    static let Kitchen = "Kitchen"
    static let Dish = "Dish"
    static let UserInfo = "UserInfo"
}

struct BuyyerTable {
    static let Kitchen = "Kitchen"
    static let Cuisine = "Cuisine"
    static let Timings = "Timings"
    static let Food = "Food"
    static let Order = "Order"
    static let Payment = "Payment"
}

struct DishTable {
    static let Name = "Name"
    static let Quantity = "Quantity"
    static let Pricing = "Pricing"
    static let Style = "Style"
}
