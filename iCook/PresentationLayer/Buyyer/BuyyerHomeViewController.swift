//
//  BuyyerHomeViewController.swift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 6/5/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit
import FirebaseDatabase

class BuyyerHomeViewController: UIViewController {

    @IBOutlet weak var dishesTableView: UITableView!
    var ref: DatabaseReference!
    var dishesRefHandle: DatabaseHandle!

    var sellers = [Seller]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViews()
        Overlay.show(on: self.view)
        FirebaseUtil.getSellersForBuyyer(sellers: { sellersArray in
            self.sellers = sellersArray
            self.dishesTableView.reloadData()
            Overlay.hide()
        })
        self.navigationItem.rightBarButtonItem = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkAndShowOrHideNextButton()
    }

    @objc func nextBarButtonItemTapped() {
        guard let selectedDishesVC = Util.viewControllerFrom(storyboard: .buyyerSelectedDishes,
                                                       withIdentifier: .buyyerSelectedDishesVC)
            as? BuyyerSelectedDishesViewController else {
                fatalError("No view controller with identifier BuyyerSelectedDishesViewController")
        }
        selectedDishesVC.sellers = sellers
        self.navigationController?.pushViewController(selectedDishesVC, animated: true)
    }

    func nextBarButtonItem() -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(title: "Next",
                                            style: .done,
                                            target: self,
                                            action: #selector(nextBarButtonItemTapped))
        return barButtonItem
    }

    func checkAndShowOrHideNextButton() {
        var isSelectedDishes = false
        for seller in sellers {
            let selectedDishes = seller.dishes.filter() { $0.isAddedToOder == true }
            if selectedDishes.isEmpty == false {
                isSelectedDishes = true
                break
            }
        }
        self.navigationItem.rightBarButtonItem = isSelectedDishes ? nextBarButtonItem() : nil
    }
}
