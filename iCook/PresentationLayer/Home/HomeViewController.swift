//
//  HomeViewController.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 6/6/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

enum headerButtonStyle:Int {
    case left
    case right
    case both
}

enum controller:Int {
    case sellerKitchen
    case sellerHome
    case sellerAddDish
    case buyerHome
}

@objc protocol buttonActions {
    
    @objc
    optional
    func cancelTapped(_ sender: UIButton)
    
    @objc
    optional func menuTapped(_ sender: AnyObject)
}

class HomeViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet public weak var headerViewTitle: UILabel!
    @IBOutlet weak var headerRightButton: UIButton!
    @IBOutlet weak var headerLeftButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var rightButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftButtonWidthConstraint: NSLayoutConstraint!
    
    var currentChildController:UIViewController?


    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupHeaderView(_ withButton:headerButtonStyle, buttons:[UIImage]) {
        switch withButton {
        case .left:
            rightButtonWidthConstraint.constant = 0.0
            leftButtonWidthConstraint.constant = 36.0
        case .right:
            leftButtonWidthConstraint.constant = 0.0
            rightButtonWidthConstraint.constant = 36.0
            headerRightButton.setImage(buttons.first, for: .normal)
        case .both:
            leftButtonWidthConstraint.constant = 36.0
            rightButtonWidthConstraint.constant = 36.0
        }
        self.view.layoutIfNeeded()
    }
    
    func setTitleText(_ title:String) {
        headerViewTitle.text = title
    }
    
    func addAsChildViewController(_ forController:controller) {
        switch forController {
        case .sellerKitchen:
            guard let sellerKitchen = Util.viewControllerFrom(storyboard: .kitchen,
                                                                         withIdentifier: .kitchenNavVC)
                as? SellerShopViewController else {
                    fatalError("No view controller with identifier SellerHomeViewController")
            }
            if currentChildController == nil {
                currentChildController = sellerKitchen
            } else {
                removeContentController(currentChildController!)
                currentChildController = sellerKitchen
            }
            addContentViewController(sellerKitchen)

        case .sellerHome:
            
            guard let sellerHome = Util.viewControllerFrom(storyboard: .sellerHome,
                                                              withIdentifier: .sellerHomeViewController)
                as? SellerHomeViewController else {
                    fatalError("No view controller with identifier SellerHomeViewController")
            }
            if currentChildController == nil {
                currentChildController = sellerHome
            } else {
                removeContentController(currentChildController!)
                currentChildController = sellerHome

            }
            addContentViewController(sellerHome)
            
        case .sellerAddDish:
            
            guard let sellerDish = Util.viewControllerFrom(storyboard: .addDish,
                                                              withIdentifier: .addDishNavVC)
                as? SellerAddDishViewController else {
                    fatalError("No view controller with identifier SellerHomeViewController")
            }
            if currentChildController == nil {
                currentChildController = sellerDish
            } else {
                removeContentController(currentChildController!)
                currentChildController = sellerDish
            }
            addContentViewController(sellerDish)
            headerRightButton.addTarget(sellerDish,
                                        action: #selector(buttonActions.cancelTapped(_:)),
                                        for: .touchUpInside)
            
        case .buyerHome:
            guard let buyerHome = Util.viewControllerFrom(storyboard: .buyyerHome,
                                                              withIdentifier: .buyyerHomeNavVC)
                as? BuyyerHomeViewController else {
                    fatalError("No view controller with identifier SellerHomeViewController")
            }
            if currentChildController == nil {
                currentChildController = buyerHome
            } else {
                removeContentController(currentChildController!)
                currentChildController = buyerHome
            }
            addContentViewController(buyerHome)
        }
    }
    
    
    func addContentViewController(_ content: UIViewController) {
        addChildViewController(content)
        containerView.addSubview(content.view)
        content.didMove(toParentViewController: self)
    }
    
    func removeContentController(_ content: UIViewController) {
        content.willMove(toParentViewController: nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }

    

}
