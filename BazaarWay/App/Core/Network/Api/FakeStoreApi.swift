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
enum FakeStoreApi {
    case products
    case categories
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
        case .categories:
            return "/categories"
        case .products:
            return "/"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .categories:
            return .requestPlain
        case .products:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
