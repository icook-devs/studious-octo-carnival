//
//  HomeMenuViewController.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 6/7/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
}

struct ItemData {
    var title: String
    var description: String
    var image: UIImage
    
    init(title: String, image: UIImage, description: String) {
        self.title = title
        self.image = image
        self.description = description
    }
}

enum userType {
    case Buyer
    case Seller
}

enum MenuItems:Int {
    case sellarHome, buyerHome, history, orders, kitchen, profile, signout
    
    static var sellerItems:[MenuItems] = {
        return [MenuItems.sellarHome,
                MenuItems.orders,
                MenuItems.kitchen,
                MenuItems.profile,
                MenuItems.signout]
    }()
    
    static var buyerItems:[MenuItems] = {
        return [MenuItems.buyerHome, MenuItems.history, MenuItems.profile, MenuItems.signout]
    }()
    
    func item() -> ItemData {
        switch self {
        case .sellarHome:
            return ItemData(title: MenuView.homeTitle,
                            image: #imageLiteral(resourceName: "Home"),
                            description: MenuView.sellerHomeSBId)
        case .buyerHome:
            return ItemData(title: MenuView.homeTitle,
                            image: #imageLiteral(resourceName: "Home"),
                            description: MenuView.buyerHomeSBId)
        case .history:
            return ItemData(title: MenuView.historyTitle,
                            image: #imageLiteral(resourceName: "History"),
                            description: MenuView.historyTitle)
        case .orders:
            return ItemData(title: MenuView.ordersTitle,
                            image: #imageLiteral(resourceName: "Orders"),
                            description: MenuView.ordersTitle)
        case .kitchen:
            return ItemData(title: MenuView.kitchenTitle,
                            image: #imageLiteral(resourceName: "kitchen"),
                            description: MenuView.kitchenTitle)
        case .profile:
            return ItemData(title: MenuView.profileTtile,
                            image: #imageLiteral(resourceName: "Profile"),
                            description: MenuView.profileTtile)
        case .signout:
            return ItemData(title: MenuView.signoutTitle,
                            image: #imageLiteral(resourceName: "Logout"),
                            description: MenuView.signoutTitle)
        }
    }

}

private let reuseIdentifer = "HomeMenuCell"
class HomeMenuViewController: UIViewController {

    @IBOutlet weak var menuTableView: UITableView!
    var menuProtocol: MenuActionProtocol?
    var userMode = userType.Buyer as userType
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        menuTableView.rowHeight = 60
        menuTableView.estimatedRowHeight = UITableView.automaticDimension
        menuTableView.contentInset = UIEdgeInsets(top: 14, left: 0, bottom: 0, right: 0)
    }
}

// MARK: Datasource Methods
extension HomeMenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userMode == .Buyer {
            return MenuItems.buyerItems.count
        }
        return MenuItems.sellerItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as? MenuItemCell
            else {
                return UITableViewCell()
        }
    
        if userMode == .Buyer {
            let row = MenuItems.buyerItems[indexPath.row]
            cell.cellTitle.text = row.item().title
            cell.cellImage.image = row.item().image

        } else {
            let row = MenuItems.sellerItems[indexPath.row]
            cell.cellTitle.text = row.item().title
            cell.cellImage.image = row.item().image
        }
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: Delegate Methods
extension HomeMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userMode == .Buyer {
            let row = MenuItems.buyerItems[indexPath.row]
            menuProtocol?.menuItemSelected(item: row)
        } else {
            let row = MenuItems.sellerItems[indexPath.row]
            menuProtocol?.menuItemSelected(item: row)

        }
    }
}

