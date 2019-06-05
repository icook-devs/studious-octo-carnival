//
//  BuyyerDishDetailViewController.swift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 6/7/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

class BuyyerDishDetailViewController: UIViewController {
    var seller: Seller!
    var dish: Dish!

    @IBOutlet weak var sellerKitchenName: UILabel!
    
    @IBOutlet weak var sellerImageView: UIImageView!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var sellerAddress1Label: UILabel!
    @IBOutlet weak var sellerAddress2Label: UILabel!

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishStyleLabel: UILabel!
    @IBOutlet weak var dishTypeLabel: UILabel!
    @IBOutlet weak var dishQuantityLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sellerKitchenName.text = seller.kitchen?.name

        sellerNameLabel.text = seller.userInfo?.getFullName()
        sellerAddress1Label.text = seller.userInfo?.address
        sellerAddress2Label.text = seller.userInfo?.getCityStateZip()

        dishNameLabel.text = dish.name
        dishStyleLabel.text = dish.style
        dishTypeLabel.text = dish.availability
        dishPriceLabel.text = dish.getPriceString()
        dishQuantityLabel.text = dish.getQuantityString()
        if let dishImagUrl = dish.dishImageUrl {
            SellerItemHelper.downloadImageFromURL(urlStr: dishImagUrl, completion: { (img) in
                self.dishImageView.image = img
            })
        }
    }
}
