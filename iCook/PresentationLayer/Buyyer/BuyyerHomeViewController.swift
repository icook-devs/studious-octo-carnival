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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
