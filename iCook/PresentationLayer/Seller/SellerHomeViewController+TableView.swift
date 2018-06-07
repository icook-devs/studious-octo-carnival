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
        if let dishImagUrl = dish.dishImageUrl {
            SellerItemHelper.downloadImageFromURL(urlStr: dishImagUrl, completion: { (img) in
                cell.dishImageView.image = img
            })
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dish = dishes[indexPath.row]
        
        guard let addDishViewController = Util.viewControllerFrom(storyboard: .addDish,
                                                                  withIdentifier: .addDishNavVC)
            as? SellerAddDishViewController else {
                fatalError("No view controller with identifier SellerAddDishViewController")
        }
        addDishViewController.delegate = self
        addDishViewController.dish = dish
        addDishViewController.mode = DishViewMode.display
        self.navigationController?.pushViewController(addDishViewController, animated: true)

    }
}

