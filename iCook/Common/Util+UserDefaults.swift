//
//  MDFAUtil+UserDefaults.swift
//  PharmacyCycleCount
//
//  Created by Sambasiva Rao Dodigam on 3/7/17.
//  Copyright © 2017 Kaiser Permanente. All rights reserved.
//

import UIKit

extension Util {

    class func setValue(_ value: Any, key: UserDefaultsKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }

    class func getBool(_ forKey: UserDefaultsKey) -> Bool {
        return UserDefaults.standard.bool(forKey: forKey.rawValue)
    }

    class func getInt(_ forKey: UserDefaultsKey) -> Int {
        return UserDefaults.standard.integer(forKey: forKey.rawValue)
    }

    class func getFloat(_ forKey: UserDefaultsKey) -> Float {
        return UserDefaults.standard.float(forKey: forKey.rawValue)
    }

    class func getDouble(_ forKey: UserDefaultsKey) -> Double {
        return UserDefaults.standard.double(forKey: forKey.rawValue)
    }

    class func getString(_ forKey: UserDefaultsKey) -> String? {
        if let string = UserDefaults.standard.string(forKey: forKey.rawValue) {
            return string
        }
        return nil
    }

    class func getObject(_ forKey: UserDefaultsKey) -> Any? {
        if let object = UserDefaults.standard.object(forKey: forKey.rawValue) {
            return object
        }
        return nil
    }

}
