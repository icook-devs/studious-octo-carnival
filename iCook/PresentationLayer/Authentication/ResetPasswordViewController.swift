//
//  ResetPasswordViewController.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 6/1/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func resetPassword(_ sender: Any) {
        
        AuthenticationService.resetPasswordWith(email: emailField.text!) { (success) in
            if success {
                // show successful alert
                //and pop back to login screen
            } else {
                // show failure alert
            }
        }
    }
    
}
