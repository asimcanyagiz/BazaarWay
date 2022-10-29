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
    var numberOfRows2: Int {
        var products2 = products?.filter({ $0.category.hasPrefix("jewelery")})
        return products2?.count ?? .zero
    }
    
    
    //MARK: - Tabbar Setup
    func setBasketButton(controller: UIViewController){
        
        let basketButtonImage = UIImage(systemName: "basket")
        let basketBarButtonItem = UIBarButtonItem(image: basketButtonImage, style: .plain, target: self, action: #selector(basketButton))
        basketBarButtonItem.tintColor = .black
        
        controller.tabBarController?.navigationItem.rightBarButtonItem = basketBarButtonItem
    }
    
    @objc func basketButton(){
         print("clicked")
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
    
    //Call the current photo
    func productsForIndexPath(_ indexPath: IndexPath) -> Products? {
        products?[indexPath.row]
    }
    func productsForIndexPath2(_ indexPath: IndexPath) -> Products? {
        var products2 = products?.filter({ $0.category.hasPrefix("jewelery")})
        return products2?[indexPath.row]
    }
}
