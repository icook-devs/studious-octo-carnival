//
//  SellerHomeViewController.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 5/23/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol shopSetupProtocol {
    func fetchShopDetails(data: [String: AnyObject]?)
    func getTodayDish(data: [String: AnyObject]?)

}
class SellerHomeViewController: UIViewController,shopSetupProtocol {
   
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var firstSetupView: UIView!
    @IBOutlet weak var dishesTableView: UITableView!
    
    var ref: DatabaseReference!
    var refHandle: DatabaseHandle!
    var dishesRefHandle: DatabaseHandle!
    var dishes = [[String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViews()
        let isKitchenAdded = Util.getBool(.isKitchenAdded)
        firstSetupView.isHidden = isKitchenAdded
        welcomeLabel.isHidden = true
        ref = Database.database().reference()

//        refHandle = ref.child(FirebaseTable.Dish).observe(.childAdded, with: { [weak self] (snapshot) -> Void in
//            guard let strongSelf = self else { return }
//            strongSelf.dishes.append(snapshot)
//            strongSelf.dishesTableView.insertRows(at: [IndexPath(row: strongSelf.dishes.count-1, section: 0)], with: .automatic)
//        })

        dishesRefHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            if let users = postDict[FirebaseTable.Seller] as? [String : AnyObject],
                let loggedInUser = users[Util.loggedInUserUserID()] as? [String : AnyObject],
                let buyyer = loggedInUser[FirebaseTable.Buyyer] as? [String : String] {
                let kitchenName = buyyer["Kitchen"] ?? "" as String
                self.welcomeLabel.text = "Welcome to \(kitchenName)"
                self.welcomeLabel.isHidden = false
                if let dishes = loggedInUser[FirebaseTable.Dish] as? [String: Dictionary<String, String>] {
                    self.dishes.removeAll()
                    for dish in dishes {
                        self.dishes.append(dish.value)
                    }
                    self.dishesTableView.reloadData()
                }
            }
        })

    }

    func fetchShopDetails(data: [String : AnyObject]?) {
        guard let shopDetail = data else {
            return
        }
        if let kitchenName = shopDetail["Kitchen"] as? String {
            welcomeLabel.text = "Welcome to \(kitchenName)"
        }
        firstSetupView.isHidden = Util.getBool(.isKitchenAdded)
    }
    
    func getTodayDish(data: [String : AnyObject]?) {
        guard let dishDetail = data else {
            return
        }
        print(dishDetail)
    }
    
    @IBAction func addKitchen(sender: UIButton) {
        let shopNavVC = Util.navControllerFrom(storyboard: .kitchen, withIdentifier: .kitchenNavVC)
        let shopViewController = shopNavVC.viewControllers[0] as? SellerShopViewController
        shopViewController?.delegate = self
        self.present(shopNavVC, animated: true)
    }
    
    @IBAction func addItem(sender: UIButton) {
        let addDishNavVC = Util.navControllerFrom(storyboard: .addDish, withIdentifier: .addDishNavVC)
        let addDishViewController = addDishNavVC.viewControllers[0] as? SellerAddDishViewController
        addDishViewController?.delegate = self
        self.present(addDishNavVC, animated: true)
    }
    
}
