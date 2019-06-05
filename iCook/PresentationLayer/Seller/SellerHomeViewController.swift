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
class SellerHomeViewController: BaseViewController,shopSetupProtocol {
   
    //@IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var firstSetupView: UIView!
    @IBOutlet weak var dishesTableView: UITableView!
    
    var ref: DatabaseReference!
    var refHandle: DatabaseHandle!
    var dishesRefHandle: DatabaseHandle!
    var dishes = [Dish]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViews()
        let isKitchenAdded = Util.getBool(.isKitchenAdded)
        firstSetupView.isHidden = isKitchenAdded
        ref = Database.database().reference()

        dishesRefHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            if let users = postDict[FirebaseTable.Seller] as? [String : AnyObject],
                let loggedInUser = users[FirebaseUtil.loggedInUserUserID()] as? [String : AnyObject] {
//                if let kitchen = loggedInUser[FirebaseTable.Kitchen] as? [String : String] {
//                    let kitchenName = kitchen["Kitchen"] ?? "" as String
//                    self.welcomeLabel.text = "Welcome to \(kitchenName)"
//                    self.welcomeLabel.isHidden = false
//                }
                if let dishesArray = loggedInUser[FirebaseTable.Dish] as? [String: Dictionary<String, String>] {
                    self.dishes.removeAll()
                    for (key, value) in dishesArray {
                        let dishDict = value
                        let dishModel = Dish(dishDictory: dishDict as [String : AnyObject],
                                             dishID: key)
                        self.dishes.append(dishModel)
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
//        if let kitchenName = shopDetail["Kitchen"] as? String {
//            self.headerViewTitle.text = ("Welcome to \(kitchenName)")
//        }
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
        
        guard let addDishViewController = Util.viewControllerFrom(storyboard: .addDish,
                                                                         withIdentifier: .addDishNavVC)
                as? SellerAddDishViewController else {
            fatalError("No view controller with identifier SellerAddDishViewController")
            }
        addDishViewController.delegate = self
        self.navigationController?.pushViewController(addDishViewController, animated: true)
    }
    
//    //TODO# still need to optimize it
//    guard let sellerHomeViewController = Util.viewControllerFrom(storyboard: .home,
//                                                                 withIdentifier: .homeViewController)
//        as? HomeViewController else {
//    fatalError("No view controller with identifier SellerHomeViewController")
//    }
//    self.present(sellerHomeViewController, animated: true, completion: {
//    sellerHomeViewController.setupHeaderView(.right, buttons:[#imageLiteral(resourceName: "cancel")])
//    sellerHomeViewController.addAsChildViewController(.sellerAddDish)
//    sellerHomeViewController.headerViewTitle.text = "Add Dish"
//    })
    
}
