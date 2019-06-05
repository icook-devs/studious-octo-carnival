//
//  BuyyerHomeViewController.swift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 6/5/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit
import FirebaseDatabase

class BuyyerHomeViewController: BaseViewController {

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkAndShowOrHideNextButton()
    }

    func filterTapped(_ sender: AnyObject) {
        let filterNavVC = Util.navControllerFrom(storyboard: .filterDishes,
                                                 withIdentifier: .filterDishesNavVC)
        self.present(filterNavVC, animated: true, completion: nil)
    }

    func nextTapped(_ sender: AnyObject) {
        guard let selectedDishesVC = Util.viewControllerFrom(storyboard: .buyyerSelectedDishes,
                                                       withIdentifier: .buyyerSelectedDishesVC)
            as? BuyyerSelectedDishesViewController else {
                fatalError("No view controller with identifier BuyyerSelectedDishesViewController")
        }
        selectedDishesVC.sellers = sellers
        self.navigationController?.pushViewController(selectedDishesVC, animated: true)
    }


    func checkAndShowOrHideNextButton() {
        let nextButton = navigationItem.rightBarButtonItems?.last
        var isSelectedDishes = false
        for seller in sellers {
            let selectedDishes = seller.dishes.filter() { $0.isAddedToOder == true }
            if selectedDishes.isEmpty == false {
                isSelectedDishes = true
                break
            }
        }
        
        if isSelectedDishes {
            nextButton?.isEnabled = true
            nextButton?.title = "Next"
        } else {
            nextButton?.isEnabled = false
            nextButton?.title = nil
        }
    }
}
