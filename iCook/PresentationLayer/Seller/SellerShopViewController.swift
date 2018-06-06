//
//  SellerShopViewController.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 5/23/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit
import FirebaseDatabase

//class ShopCell: UITableViewCell {
//    
//    @IBOutlet weak var fieldLabel: UILabel!
//    @IBOutlet weak var fieldTextField: UITextField!
//}

enum PickerOption {
    case cusineType
    case timings
    case foodType
    case orderType
    case paymentType
}


class SellerShopViewController: UIViewController {
    
    let Kitchen = 200
    let cuisine = 201
    let timings = 202
    let food = 203
    let order = 204
    let payment = 205
    var ref: DatabaseReference!

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var kitchenNameField: UITextField!
    @IBOutlet weak var cuisineField: UITextField!
    @IBOutlet weak var timingField: UITextField!
    @IBOutlet weak var foodField: UITextField!
    @IBOutlet weak var orderField: UITextField!
    @IBOutlet weak var paymentField: UITextField!

    
//    @IBOutlet weak var tableView: UITableView!
//    var fieldArray = ["Kitchen Name", "Cuisine Type", "Timings", "Food Type", "Order Type", "Payment Type"]
    var pickerView: UIPickerView?
    var pickerDataSource = [String]()
    var selectedTexfield:UITextField?
    var keyboardToolBar: UIToolbar?
    var delegate:shopSetupProtocol?
    var shopData = [String: AnyObject]()
    
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
        
        setupTextFields()
    }
    
    
    func setupTextFields() {
        kitchenNameField.tag = Kitchen
        kitchenNameField.delegate = self
        
        cuisineField.tag = cuisine
        cuisineField.delegate = self
        cuisineField.inputView = pickerView
        cuisineField.inputAccessoryView = keyboardToolBar
        
        timingField.tag = timings
        timingField.inputView = pickerView
        timingField.inputAccessoryView = keyboardToolBar
        
        foodField.tag = food
        foodField.inputView = pickerView
        foodField.inputAccessoryView = keyboardToolBar
        
        orderField.tag = order
        orderField.inputView = pickerView
        orderField.inputAccessoryView = keyboardToolBar
        
        paymentField.tag = payment
        paymentField.inputView = pickerView
        paymentField.inputAccessoryView = keyboardToolBar
        
    }
    
    func getPickerDatasource(option: PickerOption) -> [String] {
        switch option {
        case .cusineType:
            return ["South Indian", "North Indian", "Continental", "Any"]
        case .timings:
            return ["Lunch", "Dinner", "Lunch And Dinner"]
        case .foodType:
            return ["Veg", "Non-veg", "Vegan", "veg And Non-Veg"]
        case .orderType:
            return ["Pick-up"]
        case .paymentType:
            return ["Cash"]
        }
    }

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fieldArray.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shopCell", for: indexPath) as? ShopCell else {
//            return ShopCell()
//        }
//        cell.fieldLabel.text = fieldArray[indexPath.row]
//        cell.fieldTextField.tag = 200 + indexPath.row
//        cell.fieldTextField.delegate = self
//        if indexPath.row != 0 {
//            cell.fieldTextField.inputView = pickerView
//            cell.fieldTextField.inputAccessoryView = keyboardToolBar
//        }
//        return cell
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if selectedTexfield != nil {
//            selectedTexfield?.resignFirstResponder()
//        }
//    }
    
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
        self.selectedTexfield?.resignFirstResponder()
        if isValidateEntries() == true {
            Util.setValue(true, key: .isKitchenAdded)
            self.delegate?.fetchShopDetails(data: shopData)
            let userId = FirebaseUtil.loggedInUser().uid
            self.ref.child(FirebaseTable.Seller).child(userId).child(FirebaseTable.Kitchen).setValue(shopData)
            self.dismiss(animated: true, completion: nil)
        }
    }

}

extension SellerShopViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.selectedTexfield = textField
        switch textField.tag {
        case cuisine:
            pickerDataSource = getPickerDatasource(option: .cusineType)
        case timings:
            pickerDataSource = getPickerDatasource(option: .timings)
        case food:
            pickerDataSource = getPickerDatasource(option: .foodType)
        case order:
            pickerDataSource = getPickerDatasource(option: .orderType)
        case payment:
            pickerDataSource = getPickerDatasource(option: .paymentType)
        default:
            break
        }
        self.selectedTexfield?.text = pickerDataSource.first
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case Kitchen:
            shopData["Kitchen"] = textField.text as AnyObject
        case cuisine:
            shopData["Cuisine"] = textField.text as AnyObject
        case timings:
            shopData["Timings"] = textField.text as AnyObject
        case food:
            shopData["Food"] = textField.text as AnyObject
        case order:
            shopData["Order"] = textField.text as AnyObject
        case payment:
            shopData["Payment"] = textField.text as AnyObject
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
}

extension SellerShopViewController: UIPickerViewDataSource,UIPickerViewDelegate {
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
