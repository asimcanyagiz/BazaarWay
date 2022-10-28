//
//  FakeStoreApi.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 28.10.2022.
//

import Foundation
import Moya

//Moya plugin and provider for help us to connect
let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
let provider = MoyaProvider<FakeStoreApi>(plugins: [plugin])

//Cases for different call methods
enum FakeStoreApi: String {
    case allProducts = "All"
    case jewelery = "Jewelery"
    case electronics = "Electronics"
    case mens = "Men\'s"
    case womens = "Women\'s"
}

// MARK: - TargetType
extension FakeStoreApi: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://fakestoreapi.com/products")
        else {
            fatalError("Base URL not found or not in correct format")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .allProducts:
            return "/"
        case .jewelery:
            return "/category/jewelery"
        case .electronics:
            return "/category/electronics"
        case .mens:
            return "/category/men's clothing"
        case .womens:
            return "/category/women's clothing"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }
}
