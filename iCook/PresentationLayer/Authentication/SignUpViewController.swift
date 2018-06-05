//
//  SignUpViewController.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 5/29/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var userData: UserInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
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
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationItem.backBarButtonItem = nil
        self.title = "Sign Up"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedStringKey.foregroundColor:UIColor.black,
             NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 22)]
    }
    
    func validateFields() -> Bool {

        if (firstNameField.text?.isEmpty)! ||
            (lastNameField.text?.isEmpty)! ||
            (phoneField.text?.isEmpty)! ||
            (emailField.text?.isEmpty)! ||
            (passwordField.text?.isEmpty)! {
            return false
        }
        return true
    }
    
    func getUserInfo() -> UserInfo? {
        guard
        let firstName = firstNameField.text,
        let lastName = lastNameField.text,
        let phone = phoneField.text,
        let email = emailField.text else {
            return nil
        }
        
        let userInfo = UserInfo.init(firstname: firstName,
                                     lastname: lastName,
                                     email: email,
                                     phone: phone,
                                     address: "400 Summerset ln",
                                     address2: "",
                                     city: "Atlanta",
                                     state: "GA",
                                     zipcode: 30328,
                                     lat: 0.0,
                                     lon: 0.0)
        return userInfo
    }
    
    //TODO: Need to optimize as we are using in mutiple places
    func showHomeScreen() {
        guard let sellerHomeViewController = Util.viewControllerFrom(storyboard: .sellerHome,
                                                                     withIdentifier: .sellerHomeViewController)
            as? SellerHomeViewController else {
                fatalError("No view controller with identifier SellerHomeViewController")
        }
        self.navigationController?.present(sellerHomeViewController, animated: true)
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        if validateFields() {
            AuthenticationService.createUser(userData: getUserInfo(),
                                             password: passwordField.text!,
                                             completion: { (user, error) in
                                                if user != nil {
                                                    print("user created successfully")
                                                    self.showHomeScreen()
                                                } else {
                                                    // handle Error
                                                }
            })
            
        }
        
    }
    
}
