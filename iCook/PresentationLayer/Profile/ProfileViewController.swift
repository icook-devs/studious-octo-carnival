//
//  ProfileViewController.swift
//  iCook
//
//  Created by Krishna  on 6/6/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    @IBOutlet weak var  userName: UILabel!
    @IBOutlet weak var  profileImage: UIImageView!
    @IBOutlet weak var  userEmailId: UILabel!
    @IBOutlet weak var  homeTableView: UITableView!
    let profileTableViewCellTitle = "title: "
    var myAccountListArray:[AnyObject] = []

    override func viewDidLoad() {
        
        
//        let button1 = UIBarButtonItem(image: UIImage(named: "cancel"),
//                                      style: .plain, target: self, action: Selector(("signout")))
//        self.navigationItem.rightBarButtonItem = button1
        let firstCell = [profileTableViewCellTitle: "Account Settings"]
        let secondCell = [profileTableViewCellTitle: "Transaction History"]
        let thirdCell = [profileTableViewCellTitle: "Change Password"]
        let fourthCell = [profileTableViewCellTitle: "SignOut"]
        myAccountListArray = [firstCell, secondCell, thirdCell,fourthCell] as [AnyObject]
        
    }
    func signout() {
        try! Auth.auth().signOut()
        self.navigationController?.popViewController(animated: false)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myAccountListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueResuableCell(withClass: ProfileCell.self)
        cell.titleLabel.text = myAccountListArray[indexPath.row][profileTableViewCellTitle] as? String
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProfileCell
        if cell.titleLabel.text == "SignOut" {
            signout()
        }
        
    }
    
  
    

}
