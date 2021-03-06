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
    @IBOutlet weak var loginInAsSwitch: UISwitch!
    @IBOutlet weak var loginButton: UIButton!

    var errorString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        emailField.text = "pranavik1@gmail.com" //emailTextField.text ?? ""
        passwordField.text = "samba537" //passwordTextField.text ?? ""
        updateLoginButton()
//        emailField.text = "sharat.guduru+2@gmail.com" //emailTextField.text ?? ""
//        passwordField.text = "Abc123" //passwordTextField.text ?? ""
        
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
            [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor:UIColor.black,
             NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 22)]
    }

    func updateLoginButton() {
        let loginButtonText = loginInAsSwitch.isOn ? "Login As Buyyer" : "Login As Seller"
        loginButton.setTitle(loginButtonText, for: .normal)
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

    func showBuyyerHomeScreen() {
        self.showHomeScreen(type: .Buyer)

//        let buyyerHomeNavVC = Util.navControllerFrom(storyboard: .buyyerHome,
//                                                              withIdentifier: .buyyerHomeNavVC)
//        self.present(buyyerHomeNavVC, animated: true)
    }

    func checkKitchenAddedStatusAndShowSellerScreen() {
        FirebaseUtil.isKitchenAdded(isAdded: { [weak self] isAdded in
            Overlay.hide()
            
            self?.showHomeScreen(type: .Seller)
//            if isAdded == true {
//                self.showHomeScreen()
//            } else {
//                self.showAddKitchenVC()
//            }
        })
    }

    func showHomeScreen() {
        let sellerHomeViewController = Util.navControllerFrom(storyboard: .sellerHome,
                                                              withIdentifier: .sellerHomeNavVC)
        
        self.navigationController?.present(sellerHomeViewController, animated: true, completion: {
//            sellerHomeViewController.setupHeaderView(.right,
//                                                     buttons: [#imageLiteral(resourceName: "menu")])
//            sellerHomeViewController.addAsChildViewController(.sellerHome)
        })
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
            Overlay.show(on: self.view,
                         isTrasparent: true,
                         loadingText: "Logging in ..",
                         overlayAlpha: 0.5)
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    Util.appDelegate().loggedInAsBuyyer = self.loginInAsSwitch.isOn
                    if self.loginInAsSwitch.isOn == true {
                        Overlay.hide()
                        self.showBuyyerHomeScreen()
                    } else {
                        self.checkKitchenAddedStatusAndShowSellerScreen()
                    }
                } else {
                    Overlay.hide()
                    Util.showOkAlert(title: "Login Failed", message: error?.localizedDescription)
                }
            }
        }

    }
    
    func showHomeScreen(type: userType) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
            if let homeController = storyboard.instantiateViewController(
                withIdentifier: StoryboardID.homeViewController.rawValue) as? HomeViewController {
                homeController.typeUser = type
                self.navigationController?.present(homeController, animated: true)
            }
        }
    }
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
    }

    @IBAction func loginAsSwitchValueChanged(_ sender: UISwitch) {
        updateLoginButton()
    }
}

