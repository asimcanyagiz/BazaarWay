//
//  Products.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 28.10.2022.
//

import Foundation

// MARK: - WelcomeElement
struct Products: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}
extension Products {
    var imageURL: URL {
        URL(string: image)!
    }
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}
