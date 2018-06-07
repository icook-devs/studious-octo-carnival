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
        ref = Database.database().reference()
        dishesRefHandle = ref.observe(.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            if let sellers = postDict[FirebaseTable.Seller] as? [String : AnyObject] {
                for seller in sellers.values {
                    let sellerModel = Seller()
                    if let sellerObject = seller as? [String: AnyObject] {
                        if let kitchenDict = sellerObject[FirebaseTable.Kitchen] as? [String: AnyObject] {
                            sellerModel.kitchen = Kitchen(kitchenDictory: kitchenDict)
                        }
                        if let dishes = sellerObject[FirebaseTable.Dish] as? [String : AnyObject] {
                            var disheModels = [Dish]()
                            for (key, value) in dishes {
                                if let dishDict = value as? [String: AnyObject] {
                                    let dishModel = Dish(dishDictory: dishDict as [String : AnyObject],
                                                     dishID: key)
                                    disheModels.append(dishModel)
                                }
                            }
                            sellerModel.dishes = disheModels
                        }
                        self.sellers.append(sellerModel)
                    }
                }
                NSLog("\(self.sellers)")
                self.dishesTableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
