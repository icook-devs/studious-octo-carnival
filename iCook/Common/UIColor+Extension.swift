//
//  UIColor+Extension.swift
//  PharmacyMobileCheckIn
//
//  Created by Sambasiva Rao Dodigam on 3/7/17.
//  Copyright © 2017 Kaiser Permanente. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alphaVal: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: alphaVal)
    }

    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: red, green: green, blue: blue, alphaVal: 1.0)
    }

    //Usage UIColor(hex:0xFFFFFF)
    convenience init(hex: Int) {
        self.init(red: (hex >> 16) & 0xff,
                  green: (hex >> 8) & 0xff,
                  blue: hex & 0xff)
    }

    class func orderButtonBlue() -> UIColor {
        return UIColor(hex: 0x006C9A)
    }

    class func orderButtonGreen() -> UIColor {
        return UIColor(hex: 0x008800)
    }

}
