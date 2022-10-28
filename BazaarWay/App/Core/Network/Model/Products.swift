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
    
    var ratingToStar: String {
        var results = ""
        for _ in 0...Int(rating.rate){
            results.append("★")
        }
        if results.count < 5 {
            results.append("☆")
        }
        return results
    }
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}
