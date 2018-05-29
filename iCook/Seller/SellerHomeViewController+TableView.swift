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
        dishesTableView.estimatedRowHeight =  105
        dishesTableView.rowHeight = UITableViewAutomaticDimension

        // Register the Cells using the NibLoadableView Protocol
        dishesTableView.register(DishTableViewCell.self)
    }

    // MARK: - Table View Row Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueResuableCell(withClass: DishTableViewCell.self)
        let dish = dishes[indexPath.row]
        cell.nameLabel.text = dish[DishTable.Name] ?? ""
        cell.quantityLabel.text = dish[DishTable.Quantity]! + "lb"
        cell.priceLabel.text = "$" + dish[DishTable.Pricing]!
        cell.dishTypeLabel.text = dish[DishTable.Style] ?? ""

        return cell
    }
}

