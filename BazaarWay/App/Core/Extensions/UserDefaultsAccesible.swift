//
//  UserDefaultsAccesible.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 24.10.2022.
//

import Foundation

protocol UserDefaultsAccessible {}

//We create speacial variables for connection firebase
extension UserDefaultsAccessible {
    var defaults: UserDefaults {
        UserDefaults.standard
    }
    
    var uid: String? {
        stringDefault(for: .uid)
    }
    
    func stringDefault(for key: UserDefaultConstants) -> String? {
        defaults.string(forKey: key.rawValue)
    }
}
