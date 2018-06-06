//
//  SignUpViewController.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 5/29/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit
import CoreLocation
class SignUpViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var addressField2: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipcodeField: UITextField!
    var userData: UserInfo?
    var coordinates: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        
        firstNameField.text = "Robin"
        lastNameField.text = "Guduru"
        phoneField.text = "1231231234"
        emailField.text = "sharat.guduru+2@gmail.com"
        passwordField.text = "Abc123"
        addressField.text = "330 summerset ln"
        addressField2.text = ""
        cityField.text = "Atlanta"
        stateField.text = "GA"
        zipcodeField.text = "30328"
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
            (passwordField.text?.isEmpty)! ||
            (addressField.text?.isEmpty)! ||
            (cityField.text?.isEmpty)! ||
            (stateField.text?.isEmpty)! ||
            (zipcodeField.text?.isEmpty)! {
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
                                     address: addressField.text!,
                                     address2: addressField2.text!,
                                     city: cityField.text!,
                                     state: stateField.text!,
                                     zipcode: Int(zipcodeField.text!)!,
                                     lat: (self.coordinates?.longitude)!,
                                     lon: (coordinates?.longitude)!)
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
        let addressStr = SignUpHelper.formatAddress(add: addressField.text!,
                                                    add2: addressField2.text!,
                                                    city: cityField.text!,
                                                    state: stateField.text!,
                                                    zip: Int(zipcodeField.text!)!) as String
        
        SignUpHelper.getCoordinatesFrom(address: addressStr) {[weak self] (coord, error) in
            
            if error != nil {
                // show error
                return
            }
            
            self?.coordinates = coord
            
            if (self?.validateFields())! {
                AuthenticationService.createUser(userData: self?.getUserInfo(),
                                                 password: (self?.passwordField.text!)!,
                                                 completion: { (user, error) in
                                                    if user != nil {
                                                        print("user created successfully")
                                                        self?.showHomeScreen()
                                                    } else {
                                                        // handle Error
                                                    }
                })
            }
            
            
            
        }
        
    }
    
}
