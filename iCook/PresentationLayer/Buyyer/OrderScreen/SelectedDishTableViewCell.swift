//
//  SelectedDishTableViewCell.swift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 6/8/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

class SelectedDishTableViewCell: UITableViewCell, NibLoadableView {
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
    @IBOutlet weak var dishQuantityLabel: UILabel!
    @IBOutlet weak var dishStyleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(dish: Dish) {
        dishNameLabel.text = dish.name
        dishQuantityLabel.text = dish.getQuantityString()
        dishPriceLabel.text = dish.getPriceString()
        dishStyleLabel.text = dish.style
        if let dishImagUrl = dish.dishImageUrl {
            SellerItemHelper.downloadImageFromURL(urlStr: dishImagUrl, completion: { (img) in
                self.dishImageView.image = img
            })
        }
    }
}
