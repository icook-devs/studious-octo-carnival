//
//  ViewController.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 5/23/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorLblHeightConstraint: NSLayoutConstraint!
    
    var errorString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        
        emailField.text = "sharat.guduru@gmail.com" //emailTextField.text ?? ""
        passwordField.text = "robin44DV" //passwordTextField.text ?? ""

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.registerKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scrollView.deRegisterKeyboard()
    }
    
    func setupNavigationController() {
        self.title = "Log In"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedStringKey.foregroundColor:UIColor.black,
             NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 22)]
    }

    func isValidCredentilas() -> Bool {
        var isValid = true
        
        if (emailField.text?.isEmpty)! &&
            (passwordField.text?.isEmpty)! {
            errorString = "Please enter email and password"
            isValid = false
        } else if SignUpHelper.isValidEmail(email: emailField.text!) == false {
            errorString = "Please enter valid email"
            isValid = false
        } else if SignUpHelper.isValidPassword(password: passwordField.text!) == false {
            errorString = "Please enter valid password"
            isValid = false
        }
        
        if !isValid {
            errorLabel.text = errorString
            showError(hide: false)
        } else {
            errorLabel.text = ""
            showError(hide: true)
        }
        return isValid
        
    }
    
    func showError(hide:Bool) {
        if !hide {
            UIView.animate(withDuration: 0.25, animations: { [weak self] in
                self?.errorLblHeightConstraint.constant = 0
                self?.errorLabel.isHidden = false
                self?.view.layoutIfNeeded()
                }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.25, animations: { [weak self] in
                self?.errorLblHeightConstraint.constant = 25
                self?.errorLabel.isHidden = true
                self?.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    //MARK: UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            //loginButtonTapped()
        }
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showError(hide: true)
    }

    func showHomeScreen() {
        guard let sellerHomeViewController = Util.viewControllerFrom(storyboard: .sellerHome,
                                                                     withIdentifier: .sellerHomeViewController)
            as? SellerHomeViewController else {
                fatalError("No view controller with identifier SellerHomeViewController")
        }
        self.navigationController?.present(sellerHomeViewController, animated: true)
    }

    func showAddKitchenVC() {
        guard let sellerHomeViewController = Util.viewControllerFrom(storyboard: .sellerHome,
                                                                     withIdentifier: .sellerHomeViewController)
            as? SellerHomeViewController else {
                fatalError("No view controller with identifier SellerHomeViewController")
        }
        self.navigationController?.present(sellerHomeViewController,
                                           animated: true,
                                           completion: {
                                            let shopNavVC = Util.navControllerFrom(storyboard: .kitchen,
                                                                                   withIdentifier: .kitchenNavVC)
                                            let shopViewController = shopNavVC.viewControllers[0] as? SellerShopViewController
                                            shopViewController?.delegate = sellerHomeViewController
                                            sellerHomeViewController.present(shopNavVC, animated: true)
        })
    }

    @IBAction func loginButtonTapped() {
        if isValidCredentilas() {
            let email = emailField.text ?? "" //"sdodigam@gmail.com" //
            let password = passwordField.text ?? "" //"samba537" //
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    Util.appDelegate().user = user
                    if Util.getBool(.isKitchenAdded) == true {
                        self.showHomeScreen()
                    } else {
                        self.showAddKitchenVC()
                    }
                }
                
            }
        }

    }
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
    }
}

