//
//  ViewController.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 5/23/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func isValidCredentilas() -> Bool {
        return true
//        if emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false {
//            return true
//        } else {
//            //Display error alert
//            Util.showAlert(title: "Invalid credentials",
//                           message: "Please enter email and password")
//            return false
//        }
    }

    func showHomeScreen() {
        guard let sellerHomeViewController = Util.viewControllerFrom(storyboard: .sellerHome,
                                                                     withIdentifier: .sellerHomeViewController)
            as? SellerHomeViewController else {
                fatalError("No view controller with identifier SellerHomeViewController")
        }
        self.navigationController?.pushViewController(sellerHomeViewController,
                                                      animated: true)
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if isValidCredentilas() {
            let email = "sdodigam@gmail.com" //emailTextField.text ?? ""
            let password = "samba537" //passwordTextField.text ?? ""
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if Util.getBool(.isKitchenAdded) == false {
                    self.showHomeScreen()
                }
            }
        }

    }
}

