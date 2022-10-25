//
//  User.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 24.10.2022.
//

import Foundation

//Model for create user and save datas for firebase
struct User: Encodable {
    let username: String?
    let email: String?
    let basket: [String]?
}

extension User {
    init(from dict: [String: Any]) {
        username = dict["username"] as? String
        email = dict["email"] as? String
        basket = dict["basket"] as? [String]
    }
}
