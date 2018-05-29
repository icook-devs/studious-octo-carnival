//
//  MDFAUtil+UIAlertController.swift
//  PharmacyMobileCheckIn
//
//  Created by Sambasiva Rao Dodigam on 5/2/17.
//  Copyright © 2017 Kaiser Permanente. All rights reserved.
//

import UIKit

struct AlertParams {
    let title: String
    let message: String
    let button1Title: String
    let button2Title: String
}

extension Util {
    class func showOkAlert(title: String? = nil,
                           message: String? = nil,
                           viewController: UIViewController) {
        let alert = Util.showAlert(title: title,
                                   message: message)
        viewController.present(alert, animated: true) { () -> Void in }
    }

    class func showOkAlert(title: String? = nil,
                           message: String? = nil) {
        let alert = Util.showAlert(title: title,
                                   message: message)
        UIApplication.topViewController()?.present(alert,
                                                   animated: true,
                                                   completion: nil)
    }

    class func showAlert(title: String? = nil,
                         message: String? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default) { _ in })
        return alert
    }

    class func showOkAlert(title: String,
                           message: String,
                           viewController: UIViewController,
                           okTapped:@escaping () -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default) { _ in
                                        okTapped()
        })
        viewController.present(alert, animated: true) { () -> Void in
        }
    }

    class func showTwoButtonsAlert(params: AlertParams,
                                   viewController: UIViewController,
                                   button1Tapped:@escaping () -> Void,
                                   button2Tapped:@escaping () -> Void) {

        let alert = UIAlertController(title: params.title,
                                      message: params.message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: params.button1Title,
                                      style: .default) { _ in
                                        button1Tapped()
        })
        alert.addAction(UIAlertAction(title: params.button2Title,
                                      style: .default) { _ in
                                        button2Tapped()
        })
        viewController.present(alert, animated: true) { () -> Void in
        }
    }

}
