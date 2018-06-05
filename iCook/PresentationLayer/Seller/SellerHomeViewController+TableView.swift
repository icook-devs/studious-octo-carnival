//
//  SellerHomeViewController+TableView.swift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 5/29/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension SellerHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func setupTableViews() {
        // Register the Cells using the NibLoadableView Protocol
        dishesTableView.register(DishTableViewCell.self)
        dishesTableView.estimatedRowHeight =  UITableViewAutomaticDimension
        dishesTableView.rowHeight = 150
    }

    // MARK: - Table View Row Methods
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueResuableCell(withClass: DishTableViewCell.self)
        cell.setupCell()
        let dish = dishes[indexPath.row]
        cell.nameLabel.text = dish.name
        cell.quantityLabel.text = "\(dish.quantity)" + "lb"
        cell.priceLabel.text = "$" + "\(dish.price)"
        cell.dishTypeLabel.text = dish.style

        return cell
    }
}

