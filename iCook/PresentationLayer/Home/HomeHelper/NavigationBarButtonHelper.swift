//
//  NavigationBarButtonHelper.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 6/7/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import Foundation
import UIKit

enum BarButtonItemPosition {
    case right, left
}

enum BarButtonItemType {
    case menu
    case filter
    case next
    case back
}

protocol BarButtonItemConfiguration: class {
    func addBarbuttonItems(forType types: [BarButtonItemType], pos: BarButtonItemPosition)
}

@objc protocol BarButtonActions {
    
    @objc
    optional
    func menuTapped(_ sender: UIBarButtonItem)
    
    @objc
    optional func nextTapped(_ sender: AnyObject)
    
    @objc
    optional func navigateBack(_ sender: AnyObject)

    @objc
    optional func filterTapped(_ sender: AnyObject)
}

extension BarButtonItemConfiguration where Self: UIViewController, Self: BarButtonActions {
    
    func addBarbuttonItems(forType types: [BarButtonItemType], pos: BarButtonItemPosition) {
        var barButtonItems = [UIBarButtonItem]()
        for type in types {
            if type == .menu {
                let menuButton = barButton(with: #imageLiteral(resourceName: "menu"),
                                           action: #selector(Self.self.menuTapped(_:)))
                menuButton.tag = MenuAction.close.rawValue
                barButtonItems.append(menuButton)
            } else if type == .next {
                let nextButton = barButton(with: "Next",
                                             action: #selector(Self.self.nextTapped(_:)))
                barButtonItems.append(nextButton)
            } else if type == .back {
//                let backbutton = barButton(with: #imageLiteral(resourceName: "Chat_BackArrow"),
//                                           action: #selector(Self.self.navigateBack(_:)))
//                backbutton.accessibilityIdentifier = AccessibilityId.BackButton.rawValue
//                barButtonItems.append(backbutton)
            } else if type == .filter {
                let nextButton = barButton(with: "Filter",
                                           action: #selector(Self.self.filterTapped(_:)))
                barButtonItems.append(nextButton)
            }
        }
        if pos == .right {
            self.navigationItem.rightBarButtonItems = barButtonItems
        } else {
            self.navigationItem.leftBarButtonItems = barButtonItems
        }
    }
    
    func barButton(with image: UIImage, action: Selector?) -> UIBarButtonItem {
        let barButton =  UIBarButtonItem(image: image, style: .plain, target: self, action: action)
        return barButton
    }
    
    func barButton(with title: String, action: Selector?) -> UIBarButtonItem {
        let barButton =  UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        return barButton
    }
    
    func fixedBarButton() -> UIBarButtonItem {
        let fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpaceButton.width = 10.0
        return fixedSpaceButton
    }
}

/// Conform to this in subclasses of UIViewController and implement BarButtonActions.
protocol BarButtonConfigarable: BarButtonItemConfiguration, BarButtonActions {}
