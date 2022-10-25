//
//  Encodable+Extensions.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 24.10.2022.
//

import Foundation

//Help us for encode data
extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
