//
//  DishTableViewCell.swift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 5/29/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

class DishTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dishTypeLabel: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell() {
        self.clipsToBounds = false
        containerView.layer.cornerRadius = 8.0
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowRadius = 5.0
        containerView.layer.shadowOpacity = 1.0
        containerView.layer.shadowOffset = CGSize(width:0, height: 2)
        containerView.layer.shadowPath = UIBezierPath(rect: containerView.bounds).cgPath
    }
}
