//
//  SellerItemHelper.swift
//  iCook
//
//  Created by Sharat Robin Reddy Guduru on 6/6/18.
//  Copyright © 2018 Sharat Robin Reddy Guduru. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
enum PickerOption {
    case cusineType
    case timings
    case foodType
    case orderType
    case paymentType
    case availablityType
    case radious
}

class SellerItemHelper {
    var storageRef: Storage!
    class func getPickerDatasource(option: PickerOption) -> [String] {
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
        case .availablityType:
            return ["Today", "On-Request"]
        case .radious:
            return ["5 Miles", "10 Miles", "20 Miles", "30 Miles"]
        }
    }
    
    class func downloadImageFromURL(urlStr: String,completion: @escaping (_ image: UIImage?) -> Void ) {
        
        let storage = Storage.storage()
        let urlRefrence = storage.reference(forURL: urlStr)
        urlRefrence.getData(maxSize: 1 * 1024 * 1024) { (data, error) -> Void in
            // Create a UIImage, add it to the array
            let img = UIImage(data: data!)
            completion(img)
        }
        

    }
    
    class func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
