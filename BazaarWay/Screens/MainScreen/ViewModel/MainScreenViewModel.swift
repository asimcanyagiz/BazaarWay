//
//  MainScreenViewModel.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 26.10.2022.
//

import Foundation
import UIKit
import Moya

//Cases for change Product
enum ProductsChanges {
    case didErrorOccurred(_ error: Error)
    case didFetchProduct
}

final class MainScreenViewModel {
    
    var changeHandler: ((ProductsChanges) -> Void)?
    
    internal var products: [Products]? {
        didSet {
            self.changeHandler?(.didFetchProduct)
        }
    }
    var numberOfRows: Int {
        products?.count ?? .zero
    }
    var numberOfRowsJewelery: Int {
        let products2 = products?.filter({ $0.category.hasPrefix("jewelery")})
        return products2?.count ?? .zero
    }
    var numberOfRowsElectronics: Int {
        let products2 = products?.filter({ $0.category.hasPrefix("electronics")})
        return products2?.count ?? .zero
    }
    var numberOfRowsMens: Int {
        let products2 = products?.filter({ $0.category.hasPrefix("men's clothing")})
        return products2?.count ?? .zero
    }
    var numberOfRowsWomens: Int {
        let products2 = products?.filter({ $0.category.hasPrefix("women's clothing")})
        return products2?.count ?? .zero
    }
    
    
    
   
    
    //MARK: - Functions
    //Fetch the photos from api
    func fetchProducts(categoryText: String = "All") {
        provider.request(FakeStoreApi(rawValue: categoryText) ?? .allProducts) { result in
            switch result {
            case .failure(let error):
                self.changeHandler?(.didErrorOccurred(error))
            case .success(let response):
                do {
                    let products = try JSONDecoder().decode([Products].self, from: response.data)
                    self.products = products
                } catch {
                    self.changeHandler?(.didErrorOccurred(error))
                }
            }
        }
    }
    
    //MARK: - Index Functions
    func productsForIndexPath(_ indexPath: IndexPath) -> Products? {
        products?[indexPath.row]
    }
    func productsForIndexPathJewelery(_ indexPath: IndexPath) -> Products? {
        let products2 = products?.filter({ $0.category.hasPrefix("jewelery")})
        return products2?[indexPath.row]
    }
    func productsForIndexPathElectronics(_ indexPath: IndexPath) -> Products? {
        let products2 = products?.filter({ $0.category.hasPrefix("electronics")})
        return products2?[indexPath.row]
    }
    func productsForIndexPathMens(_ indexPath: IndexPath) -> Products? {
        let products2 = products?.filter({ $0.category.hasPrefix("men's clothing")})
        return products2?[indexPath.row]
    }
    func productsForIndexPathWomens(_ indexPath: IndexPath) -> Products? {
        let products2 = products?.filter({ $0.category.hasPrefix("women's clothing")})
        return products2?[indexPath.row]
    }
}
