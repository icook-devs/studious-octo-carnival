//
//  BuyyerDishTableViewswift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 6/6/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

class BuyyerDishTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
    @IBOutlet weak var dishQuantityLabel: UILabel!
    @IBOutlet weak var dishStyleLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!
    var addToOrderAction: (() -> Void)!

    @IBAction func addToOrderButtonTapped(_ sender: UIButton) {
        addToOrderAction()
    }

    func configureCell(dish: Dish,
                       addToOrderAction: @escaping (()-> Void)) {
        dishNameLabel.text = dish.name
        dishQuantityLabel.text = dish.getQuantityString()
        dishPriceLabel.text = dish.getPriceString()
        dishStyleLabel.text = dish.style
        setOrderButtonTitleAndColor(dish.isAddedToOder)
        self.addToOrderAction = addToOrderAction
    }

    func oderButtonTextColor(_ isAddedToOrder: Bool) -> UIColor {
        return isAddedToOrder ? UIColor.orderButtonGreen() : UIColor.orderButtonBlue()
    }

    func orderButtonTitle(_ isAddedToOrder: Bool) -> String {
        return isAddedToOrder ? "Added to Order" : "Add to Order"
    }

    func setOrderButtonTitleAndColor(_ isAddedToOrder: Bool) {
        addToOrderButton.setTitle(orderButtonTitle(isAddedToOrder), for: .normal)
        addToOrderButton.setTitleColor(oderButtonTextColor(isAddedToOrder), for: .normal)
    }
}
