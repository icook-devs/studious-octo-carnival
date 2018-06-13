//
//  BuyyerOrderTableHeaderView.swift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 6/13/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

class BuyyerOrderTableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var seller: Seller!

    func configureHeader() {
        nameLabel.text = seller.kitchen?.name ?? ""
        var address = seller.userInfo?.address
        address?.append(" ")
        address?.append(seller.userInfo?.getCityStateZip() ?? "")
        addressLabel.text = address
    }
    
    @IBAction func phoneButtonTapped(_ sender: Any) {
        if let number = seller.userInfo?.phone {
            let appendedNumber = "TEL://\(number)"
            if let url = URL(string:appendedNumber) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
    }

    @IBAction func textButtonTapped(_ sender: Any) {
        if let number = seller.userInfo?.phone {
            let appendedNumber = "sms://\(number)"
            if let url = URL(string:appendedNumber) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
    }

}
