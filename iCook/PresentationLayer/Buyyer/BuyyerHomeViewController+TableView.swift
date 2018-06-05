//
//  BuyyerHomeViewController+TableView.swift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 6/5/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

extension BuyyerHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func setupTableViews() {
        // Register the Cells using the NibLoadableView Protocol
        dishesTableView.register(DishTableViewCell.self)
        dishesTableView.estimatedRowHeight =  UITableViewAutomaticDimension
        dishesTableView.rowHeight = 150
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sellers.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let seller = sellers[section]
        return seller.dishes.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let seller = sellers[section]
        return seller.kitchen?.name ?? ""
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueResuableCell(withClass: DishTableViewCell.self)
        cell.setupCell()
        let seller = sellers[indexPath.section]
        let dish = seller.dishes[indexPath.row]
        cell.nameLabel.text = dish.name
        cell.quantityLabel.text = "\(dish.quantity)" + "lb"
        cell.priceLabel.text = "$" + "\(dish.price)"
        cell.dishTypeLabel.text = dish.style
        return cell
    }
}
