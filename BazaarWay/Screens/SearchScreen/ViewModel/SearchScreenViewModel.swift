//
//  SearchScreenViewModel.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 27.10.2022.
//

import Foundation
import UIKit
import Moya

//Cases for change Product
enum ProductChanges {
    case didErrorOccurred(_ error: Error)
    case didFetchProduct
}


final class SearchScreenViewModel {
    
    func addSearchBar(controller: SearchScreenViewController) -> UISearchBar{
        let searchBar:UISearchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = controller
        return searchBar
    }
    
    
    var changeHandler: ((ProductChanges) -> Void)?
    
    private var products: [Products]? {
        didSet {
            self.changeHandler?(.didFetchProduct)
        }
    }
    var numberOfRows: Int {
        products?.count ?? .zero
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
    
    
    
}
