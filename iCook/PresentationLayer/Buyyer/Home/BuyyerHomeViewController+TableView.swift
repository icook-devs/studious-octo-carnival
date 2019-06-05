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
        dishesTableView.register(BuyyerDishTableViewCell.self)
        dishesTableView.estimatedRowHeight =  UITableView.automaticDimension
        dishesTableView.rowHeight = 150
        let nib = UINib(nibName: "BuyyerTableHeaderView", bundle: nil)
        dishesTableView.register(nib, forHeaderFooterViewReuseIdentifier: "BuyyerTableHeaderView")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sellers.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let seller = sellers[section]
        return seller.dishes.count
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
        let cell = tableView.dequeueResuableCell(withClass: BuyyerDishTableViewCell.self)
        let seller = sellers[indexPath.section]
        let dish = seller.dishes[indexPath.row]
        cell.configureCell(dish: dish,
                           addToOrderAction: {
                            let isAddedToOder = dish.isAddedToOder
                            dish.isAddedToOder = !isAddedToOder
                            cell.setOrderButtonTitleAndColor(!isAddedToOder)
                            self.checkAndShowOrHideNextButton()
        })
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let seller = sellers[indexPath.section]
        let dish = seller.dishes[indexPath.row]
        guard let buyyerDetailVC = Util.viewControllerFrom(storyboard: .buyyerDishDetail,
                                                     withIdentifier: .buyyerDishDetailVC)
            as? BuyyerDishDetailViewController else {
                fatalError("No view controller with identifier BuyyerDishDetailViewController")
        }
        buyyerDetailVC.dish = dish
        buyyerDetailVC.seller = seller
        self.navigationController?.pushViewController(buyyerDetailVC, animated: true)
    }
}
