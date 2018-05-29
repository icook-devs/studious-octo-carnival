//
//  MDFAUtil+Storyboard.swift
//  PharmacyMobileCheckIn
//
//  Created by Sambasiva Rao Dodigam on 3/7/17.
//  Copyright © 2017 Kaiser Permanente. All rights reserved.
//

import UIKit

// Story board utilities
extension Util {

    class func storyboard(withName name: Storyboard) -> UIStoryboard {
        return UIStoryboard(name: name.rawValue, bundle: nil)
    }

    class func navControllerFrom(storyboard: Storyboard,
                                 withIdentifier identifier: StoryboardID) -> UINavigationController {
        let currentStoryboard = Util.storyboard(withName: storyboard)
        if let currentNavVC =
            currentStoryboard.instantiateViewController(withIdentifier: identifier.rawValue)
                as? UINavigationController {
            return currentNavVC
        } else {
            fatalError("No Navigation Controller with \(identifier)")
        }
    }

    class func viewControllerFrom(storyboard: Storyboard,
                                  withIdentifier identifier: StoryboardID) -> UIViewController {
        let currentStoryboard = Util.storyboard(withName: storyboard)
        return currentStoryboard.instantiateViewController(withIdentifier: identifier.rawValue) as UIViewController
    }
}
