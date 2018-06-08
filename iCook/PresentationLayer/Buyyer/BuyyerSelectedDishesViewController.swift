//
//  BuyyerSelectedDishesViewController.swift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 6/8/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

class BuyyerSelectedDishesViewController: UIViewController {
    var sellers = [Seller]()
    var selectedSellers = 0
    @IBOutlet weak var dishesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for seller in sellers {
            let selectedDishes = seller.dishes.filter() { $0.isAddedToOder == true }
            if selectedDishes.isEmpty == false {
                selectedSellers = selectedSellers + 1
            }
        }
        setupTableViews()
    }
}
