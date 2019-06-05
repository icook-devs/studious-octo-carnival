//
//  FilterDishesViewController.swift
//  iCook
//
//  Created by Sambasiva Rao Dodigam on 6/14/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit


class FilterDishesViewController: UIViewController {
    enum PickerOption {
        case cusineType
        case timings
        case foodType
        case orderType
        case paymentType
        case availablityType
    }

    let radious = 200
    let cuisine = 201
    let timings = 202
    let food = 203

    var pickerView: UIPickerView?
    var pickerDataSource = [String]()
    var selectedTexfield:UITextField?
    var keyboardToolBar: UIToolbar?
    var filterData = [String: AnyObject]()

    @IBOutlet weak var radiousField: UITextField!
    @IBOutlet weak var cuisineField: UITextField!
    @IBOutlet weak var timingField: UITextField!
    @IBOutlet weak var foodField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                        target: self,
                                        action: #selector(cancelTapped))
        self.navigationItem.leftBarButtonItem = cancelBarButton

        let barButton = UIBarButtonItem(barButtonSystemItem: .done,
                                        target: self,
                                        action: #selector(doneTapped))
        self.navigationItem.rightBarButtonItem = barButton
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

        adddPickerViewForTextField(radiousField, tag: radious)
        adddPickerViewForTextField(cuisineField, tag: cuisine)
        adddPickerViewForTextField(timingField, tag: timings)
        adddPickerViewForTextField(foodField, tag: food)
    }


    func adddPickerViewForTextField(_ texField: UITextField, tag: Int) {
        texField.tag = tag
        texField.delegate = self
        texField.inputView = pickerView
        texField.inputAccessoryView = keyboardToolBar
    }

    // MARK: - Keyboard buttons
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

    //MARK: - Bar buttons
    @objc
    func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc
    func doneTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterDishesViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.selectedTexfield = textField
        switch textField.tag {
        case cuisine:
            pickerDataSource = SellerItemHelper.getPickerDatasource(option: .cusineType)
        case timings:
            pickerDataSource = SellerItemHelper.getPickerDatasource(option: .timings)
        case food:
            pickerDataSource = SellerItemHelper.getPickerDatasource(option: .foodType)
        case radious:
            pickerDataSource = SellerItemHelper.getPickerDatasource(option: .radious)
        default:
            break
        }
        self.selectedTexfield?.text = pickerDataSource.first
        pickerView?.reloadAllComponents()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case radious:
            filterData["Radious"] = textField.text as AnyObject
        case cuisine:
            filterData["Cuisine"] = textField.text as AnyObject
        case timings:
            filterData["Timings"] = textField.text as AnyObject
        case food:
            filterData["Food"] = textField.text as AnyObject
        default:
            break
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension FilterDishesViewController: UIPickerViewDataSource,UIPickerViewDelegate {
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

