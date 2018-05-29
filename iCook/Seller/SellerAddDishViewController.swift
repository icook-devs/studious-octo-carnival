//
//  SellerAddDishViewController.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 5/24/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit
import FirebaseDatabase

class itemCell: UITableViewCell {
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var fieldTextField: UITextField!
}

class SellerAddDishViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let nameField = 300
    let styleField = 301
    let quantityField = 302
    let priceField = 303
    // add notes
    
    var ref: DatabaseReference!

    @IBOutlet weak var tableView: UITableView!
    var fieldArray = ["Item Name", "Item Style", "Item Quantity", "Item Price"]
    var pickerView: UIPickerView?
    var pickerDataSource = ["South Indian", "North Indian"]
    var selectedTexfield:UITextField?
    var keyboardToolBar: UIToolbar?
    var delegate:shopSetupProtocol?
    var dishData = [String: AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        pickerView = UIPickerView()
        pickerView?.delegate = self
        
        keyboardToolBar = UIToolbar()
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done,
                                              target: self,
                                              action:#selector(donePressed))
        let cancelButton = UIBarButtonItem.init(barButtonSystemItem: .cancel,
                                                target: self,
                                                action: #selector(cancelPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        keyboardToolBar?.setItems([cancelButton, spaceButton, doneButton], animated: false)
        keyboardToolBar?.isUserInteractionEnabled = true
        keyboardToolBar?.sizeToFit()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fieldArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? itemCell else {
            return itemCell()
        }
        cell.fieldLabel.text = fieldArray[indexPath.row]
        cell.fieldTextField.tag = 300 + indexPath.row
        cell.fieldTextField.delegate = self
        if indexPath.row == 1 {
            cell.fieldTextField.inputView = pickerView
            cell.fieldTextField.inputAccessoryView = keyboardToolBar
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedTexfield != nil {
            selectedTexfield?.resignFirstResponder()
        }
    }
    
    @objc
    func donePressed(sender: UIBarButtonItem) {
        let row = self.pickerView?.selectedRow(inComponent: 0) ?? 0
        self.selectedTexfield?.text = self.pickerDataSource[row]
        self.selectedTexfield?.resignFirstResponder()
    }
    
    @objc
    func cancelPressed(sender: UIBarButtonItem) {
        self.selectedTexfield?.text = ""
        self.selectedTexfield?.endEditing(true)
    }

    func isValidateEntries() -> Bool {
        return true
    }

    @IBAction func saveButtonTapped(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        if isValidateEntries() == true {
            Util.setValue(true, key: .isKitchenAdded)
            self.delegate?.getTodayDish(data: dishData)
            let userId = Util.loggedInUser().uid
            self.ref.child(FirebaseTable.User).child(userId).child(FirebaseTable.Dish).childByAutoId().setValue(dishData)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension SellerAddDishViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.selectedTexfield = textField
        textField.keyboardType = textField.tag > 301 ? .numberPad : .alphabet
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case nameField:
            dishData["Name"] = textField.text as AnyObject
        case styleField:
            dishData["Style"] = textField.text as AnyObject
        case quantityField:
            dishData["Quantity"] = textField.text as AnyObject
        case priceField:
            dishData["Pricing"] = textField.text as AnyObject
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension SellerAddDishViewController: UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedTexfield?.text = pickerDataSource[row]
    }
    
}
