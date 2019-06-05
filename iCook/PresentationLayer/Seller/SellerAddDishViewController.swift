//
//  SellerAddDishViewController.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 5/24/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import UIKit
import FirebaseDatabase


enum DishViewMode {
    case add
    case edit
    case display
}
class SellerAddDishViewController: UIViewController,UIAlertViewDelegate,
UINavigationControllerDelegate,UIScrollViewDelegate {

    let dishName = 300
    let dishStyle = 301
    let dishQuantity = 302
    let dishPrice = 303
    let availabilityTag = 304
    // add notes
    
    var ref: DatabaseReference!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dishNameField: UITextField!
    @IBOutlet weak var dishStyleField: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var availbilityField: UITextField!
    
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var addDishView: UIView!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var addDishButton: UIButton!
    @IBOutlet weak var barButton: UIBarButtonItem!

    
    var imagePicker: UIImagePickerController?
    var pickerView: UIPickerView?
    var pickerDataSource = [String]()
    var selectedTexfield:UITextField?
    var keyboardToolBar: UIToolbar?
    var delegate:shopSetupProtocol?
    var dishData = [String: AnyObject]()
    var dish:Dish?
    var mode = DishViewMode.add as DishViewMode
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
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
        updateImageTitle()
        setupTextFields(mode)
        setupNaviagationbar(mode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.registerKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scrollView.deRegisterKeyboard()
    }
    func setupNaviagationbar(_ forType:DishViewMode) {
        switch forType {
        case .add:
            barButton.title = "Save"
            self.navigationItem.hidesBackButton = true
        case .edit:
            barButton.title = "Update"
            self.navigationItem.hidesBackButton = true
        case .display:
            barButton.title = "Edit"
            self.navigationItem.hidesBackButton = false
        }
        self.navigationController?.navigationBar.tintColor = .white
    }
    func setupTextFields(_ forType:DishViewMode) {
        
        switch forType {
        case .add:
            dishNameField.text = ""
            dishStyleField.text = ""
            quantityField.text = ""
            priceField.text = ""
            availbilityField.text = ""
        case .edit: break
        case .display:
            dishNameField.text = self.dish?.name
            dishStyleField.text = self.dish?.style
            quantityField.text = "\(String(describing: self.dish?.price ?? 0))"
            priceField.text = "\(String(describing: self.dish?.price ?? 0))"
            availbilityField.text = self.dish?.availability
            if let dishImagUrl = self.dish?.dishImageUrl {
                SellerItemHelper.downloadImageFromURL(urlStr: dishImagUrl, completion: {[weak self] (img) in
                    self?.dishImageView.image = img
                    self?.updateImageTitle()
                })
            }
        }
        
        dishNameField.tag = dishName
        
        dishStyleField.tag = dishStyle
        dishStyleField.inputView = pickerView
        dishStyleField.inputAccessoryView = keyboardToolBar
        
        quantityField.tag = dishQuantity
        priceField.tag = dishPrice
        
        availbilityField.tag = availabilityTag
        availbilityField.inputView = pickerView
        availbilityField.inputAccessoryView = keyboardToolBar
    }
    
    
    func updateImageTitle() {
        let update = dishImageView.image != nil ? true : false
        if update {
            self.addDishButton.setTitle("", for: .normal)
        } else {
            self.addDishButton.setTitle("Add Dish Image", for: .normal)
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
        if dishImageView.image == nil {
            Util.showOkAlert(title: "Please upload a dish image", message: "")
            return false
        }

        return true
    }
    
    @IBAction func addDishImage(sender: UIButton) {
        let alert:UIAlertController = UIAlertController(title: "Add Image",
                                                        message: nil,
                                                        preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Use Camera", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Use Gallery", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(sender: UIBarButtonItem) {
        
    }
    
    func saveImageAndUpdateDB(key: String) {
        Overlay.show(on: self.view,
                     isTrasparent: true,
                     loadingText: "Saving ..",
                     overlayAlpha: 0.5)
        FirebaseUtil.uploadMedia(key, image: dishImageView.image!, completion: { (imageUrl) in
            guard let imgUrlStr = imageUrl else {
                self.navigationController?.popViewController(animated: true)
                return
            }
            self.dishData["DishImage"] = imgUrlStr as AnyObject
            let userId = FirebaseUtil.loggedInUser().uid
            self.ref.child(FirebaseTable.Seller).child(userId).child(FirebaseTable.Dish).child(key).setValue(self.dishData)
            Overlay.hide()
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    func cancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(.camera)) {
            imagePicker?.sourceType = .camera;
            self .present(imagePicker!, animated: true, completion: nil)
            imagePicker?.allowsEditing = false
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker?.sourceType = .savedPhotosAlbum;
            imagePicker?.allowsEditing = false
            self.present(imagePicker!, animated: true, completion: nil)
        }
        
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func rightBarButtonTapped(_ sender: UIBarButtonItem) {
        if sender.title == "Edit" {
            mode = .edit
            setupNaviagationbar(mode)
        } else if sender.title == "Update" {
            if self.textFieldDidEndEditingAndUpdate(selectedTexfield) {
                updateDishToFBDB((self.dish?.dishId)!)
            }
        } else {
            if self.textFieldDidEndEditingAndUpdate(selectedTexfield) {
                addDishToFBDB()
            } else {
                Util.showOkAlert(title: "Please enter data", message: "")
            }
        }
    }
    
    
    //MARK: Class Funtions
    func addDishToFBDB() {
        if isValidateEntries() == true {
            Util.setValue(true, key: .isKitchenAdded)
            self.delegate?.getTodayDish(data: dishData)
            let userId = FirebaseUtil.loggedInUser().uid
            let DBRef =  self.ref.child(FirebaseTable.Seller).child(userId).child(FirebaseTable.Dish).childByAutoId()
            DBRef.setValue(self.dishData)
            let childKey = DBRef.key
            saveImageAndUpdateDB(key: childKey)
        }
    }
    
    func updateDishToFBDB(_ forDishId:String) {
        if isValidateEntries() == true {
            self.delegate?.getTodayDish(data: dishData)
            saveImageAndUpdateDB(key: forDishId)
        }
    }
}

extension SellerAddDishViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if mode == .display {
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.selectedTexfield = textField
        if textField == dishStyleField {
            pickerDataSource = SellerItemHelper.getPickerDatasource(option: .cusineType)
        } else if textField == availbilityField {
            pickerDataSource = SellerItemHelper.getPickerDatasource(option: .availablityType)
        }
        textField.keyboardType = textField.tag > 301 ? .numberPad : .alphabet
    }

    func textFieldDidEndEditingAndUpdate(_ textField: UITextField?) -> Bool {
        guard let textField = textField else {
            return false
        }
        switch textField.tag {
        case dishName:
            dishData["Name"] = textField.text as AnyObject
        case dishStyle:
            dishData["Style"] = textField.text as AnyObject
        case dishQuantity:
            dishData["Quantity"] = textField.text as AnyObject
        case dishPrice:
            dishData["Pricing"] = textField.text as AnyObject
        case availabilityTag:
            dishData["Availability"] = textField.text as AnyObject
        default:
            break
        }
        return true
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

extension SellerAddDishViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        let image = (info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage)
        dishImageView.image = SellerItemHelper.resizeImage(image: image!,
                                                           targetSize: CGSize(width: 100, height: 100))
        self.dismiss(animated: true) { [weak self] in
            self?.updateImageTitle()
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
