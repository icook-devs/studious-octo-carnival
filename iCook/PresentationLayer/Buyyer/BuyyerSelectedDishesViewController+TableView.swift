//
//  BuyyerSelectedDishesViewController+TableView.swift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 6/8/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

extension BuyyerSelectedDishesViewController: UITableViewDataSource, UITableViewDelegate {
    func setupTableViews() {
        // Register the Cells using the NibLoadableView Protocol
        dishesTableView.register(SelectedDishTableViewCell.self)
        dishesTableView.estimatedRowHeight =  UITableViewAutomaticDimension
        dishesTableView.rowHeight = 117
        let nib = UINib(nibName: "BuyyerTableHeaderView", bundle: nil)
        dishesTableView.register(nib, forHeaderFooterViewReuseIdentifier: "BuyyerTableHeaderView")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return selectedSellers
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let seller = sellers[section]
        let selectedDishes = seller.dishes.filter() { $0.isAddedToOder == true }
        return selectedDishes.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60  // or whatever
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "BuyyerTableHeaderView") as? BuyyerTableHeaderView {
            let seller = sellers[section]
            headerView.buyyerNameLabel.text = seller.kitchen?.name ?? ""
            var address = seller.userInfo?.address
            address?.append(" ")
            address?.append(seller.userInfo?.getCityStateZip() ?? "")
            headerView.address1Label.text = address
            return headerView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueResuableCell(withClass: SelectedDishTableViewCell.self)
        let seller = sellers[indexPath.section]
        let selectedDishes = seller.dishes.filter() { $0.isAddedToOder == true }
        let dish = selectedDishes[indexPath.row]
        cell.configureCell(dish: dish)
        return cell
    }
}
