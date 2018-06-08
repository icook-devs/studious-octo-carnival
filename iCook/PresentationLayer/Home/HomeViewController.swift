//
//  HomeViewController.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 6/6/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

enum MenuAction: Int {
    case open
    case close
}

protocol MenuActionProtocol {
    //Protocol to send menu selected item
    func menuItemSelected(item: MenuItems)
    //Action Protocol to open or close the slide menu
    func slideMenu(to: MenuAction)
}

let SNAPSHOT_TAG = 100
let SLIDE_CONTRAINT: CGFloat = -250
let MENU_SEGUE = "MenuView"

class HomeViewController: UIViewController,MenuActionProtocol {

    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var menuContainerView: UIView!
    
    @IBOutlet weak var overlayView: UIView!
    
    @IBOutlet weak var menuViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainViewLeadingContraint: NSLayoutConstraint!
    
    // MARK: Variables
    var currentItem: String?
    var currentVC: UINavigationController?
    var typeUser = userType.Seller as userType
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if typeUser == .Seller {
            menuItemSelected(item: .sellarHome)
        }else {
            menuItemSelected(item: .buyerHome)
        }
        overlayView.isHidden = true
        self.setNeedsStatusBarAppearanceUpdate()
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        rightSwipeGesture.direction = .right
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        leftSwipeGesture.direction = .left
        mainContainerView.addGestureRecognizer(leftSwipeGesture)
        overlayView.addGestureRecognizer(rightSwipeGesture)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == MENU_SEGUE {
            guard let viewController = segue.destination as? HomeMenuViewController else {
                return
            }
            viewController.menuProtocol = self
            viewController.userMode = typeUser
        }
    }
    
    private func addShadow() {
        mainContainerView.layer.shadowOpacity = 0.8
        mainContainerView.layer.shadowColor = UIColor.black.cgColor
        mainContainerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        mainContainerView.layer.shadowRadius = 4.0
        let shadowRect: CGRect = mainContainerView.bounds.insetBy(dx: 0, dy: 4)
        mainContainerView.layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
    }
    
    func slideMenu(to: MenuAction) {
        let menuButton =
            self.currentVC?.topViewController?.navigationItem.rightBarButtonItems?.first
        menuButton?.tag = to.rawValue
        
        switch to {
        case .open:
            openMenu()
        case .close:
            closeMenu()
        }
    }
    
    private func closeMenu() {
        UIView.animate(withDuration: 0.25, animations: {
            self.overlayView.isHidden = true
            self.menuViewLeadingConstraint.constant = SLIDE_CONTRAINT
            self.mainViewLeadingContraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    private func openMenu() {
        UIView.animate(withDuration: 0.25, animations: {
            self.overlayView.isHidden = false
            self.addShadow()
            self.menuViewLeadingConstraint.constant = 0
            self.mainViewLeadingContraint.constant = SLIDE_CONTRAINT
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK: Gesture Action
    @objc
    func respondToSwipeGesture(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            slideMenu(to: .open)
        case .right:
            slideMenu(to: .close)
        default:
            break
        }
    }
    
    // MARK: Protocol Methods
    
    func menuItemSelected(item: MenuItems) {
        switch item {
        case .sellarHome:
                showSellarHome()
        case .buyerHome:
            showBuyerHome()
        case .orders:
            print("Orders Tapped")
        case .kitchen:
            print("Kitchen Tapped")
        case .profile:
            print("Profile Tapped")
        case .signout:
            print("SignOut Tapped")
        
        case .history:
            print("History Tapped")

        }
    }
    
    func showSellarHome() {
        openSegue(storyboard: Util.storyboard(withName: .sellerHome), item: .sellarHome)
    }
    
    func showBuyerHome() {
        openSegue(storyboard: Util.storyboard(withName: .buyyerHome), item: MenuItems.buyerHome)

    }
    
    // MARK: Add or Remove VC to Container
    
    func openSegue(storyboard: UIStoryboard, item: MenuItems) {
        
        let newItem = item.item().description
        if  currentItem != newItem {
            currentItem = newItem
            
            guard let viewController = storyboard.instantiateViewController(withIdentifier: newItem)
                as? BaseViewController else {
                    return
            }
            viewController.menuProtocol = self
            DispatchQueue.main.async {
                let navigationController = viewController.embedNavigationCntrlWithBarButtons(controller: viewController,
                                                                                             identifer: item)
                if let vc = self.currentVC {
                    self.removeViewController(controller: vc)
                } else {
                    self.currentVC = navigationController
                }
                self.addViewContoller(controller: navigationController)
            }
        }
        slideMenu(to: .close)
    }
    
    private func addViewContoller(controller: UINavigationController) {
        currentVC = controller
        addChildViewController(controller)
        // Add Child View as Subview
        mainContainerView.addSubview(controller.view)
        // Configure Child View
        controller.view.frame = mainContainerView.bounds
        // Notify Child View Controller
        controller.didMove(toParentViewController: self)
    }
    
    private func removeViewController(controller: UINavigationController) {
        // Notify Child View Controller
        controller.willMove(toParentViewController: nil)
        // Remove Child View From Superview
        controller.view.removeFromSuperview()
        // Notify Child View Controller
        controller.removeFromParentViewController()
    }
}
