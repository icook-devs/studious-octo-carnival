//
//  BaseViewController.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 6/7/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, BarButtonConfigarable {

    var menuProtocol: MenuActionProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func embedNavigationCntrlWithBarButtons(controller: UIViewController,
                                            identifer: MenuItems) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.barTintColor = UIColor(hex: 0xFF3333)
        navController.navigationBar.tintColor = .white
        navController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        setupNavigationBar(selectedMenu: identifer)
        return navController
    }
    
    // Add Barbutton items based on selected menu item.
    func setupNavigationBar(selectedMenu: MenuItems) {
        switch selectedMenu {
        case .sellarHome, .kitchen, .orders, .profile,.history:
            self.addBarbuttonItems(forType: [.menu], pos: .right)
        case .buyerHome:
            self.addBarbuttonItems(forType: [.menu,.next], pos: .right)
        case .signout:break
        }
        self.title = selectedMenu.item().title
    }
    
    // MARK: Protocol Method
    func menuTapped(_ sender: UIBarButtonItem) {
        if sender.tag == MenuAction.open.rawValue {
            menuProtocol?.slideMenu(to: .close)
        } else {
            menuProtocol?.slideMenu(to: .open)
        }
    }

}
