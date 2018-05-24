//
//  SellerHomeViewController.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 5/23/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit
protocol shopSetupProtocol {
    func fetchShopDetails(data: [String: AnyObject]?)
    func getTodayDish(data: [String: AnyObject]?)

}
class SellerHomeViewController: UIViewController,shopSetupProtocol {
   
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var firstSetupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstSetupView.isHidden = false
        welcomeLabel.text = "Welcome to ABC Kitchen"

    }

    func fetchShopDetails(data: [String : AnyObject]?) {
        guard let shopDetail = data else {
            return
        }
        if let kitchenName = shopDetail["Kitchen"] as? String {
            welcomeLabel.text = "Welcome to \(kitchenName)"
        }
        firstSetupView.isHidden = true
    }
    
    func getTodayDish(data: [String : AnyObject]?) {
        guard let dishDetail = data else {
            return
        }
        print(dishDetail)
    }
    
    @IBAction func addKitchen(sender: UIButton) {
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "ShopVC") as! SellerShopViewController
        vc.delegate = self
        let nav = UINavigationController.init(rootViewController: vc)
        self.present(nav, animated: true)
    }
    @IBAction func addItem(sender: UIButton) {
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "itemVC") as! SellerAddDishViewController
        vc.delegate = self
        let nav = UINavigationController.init(rootViewController: vc)
        self.present(nav, animated: true)
    }
    
}
