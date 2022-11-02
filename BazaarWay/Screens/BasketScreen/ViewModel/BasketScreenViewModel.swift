//
//  BasketScreenViewModel.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 3.11.2022.
//

import Foundation
import FirebaseFirestore

//Cases for change Product
enum BasketFetched {
    case didErrorOccurred(_ error: Error)
    case didFetchBasket
}

final class BasketScreenViewModel: UserDefaultsAccessible {
    
    
    var changeHandler: ((BasketFetched) -> Void)?
    
    //MARK: - Firebase Connect
    private let db = Firestore.firestore()
    private let defaults = UserDefaults.standard
    
    //MARK: - Get Basket
//    var basketList = [[String:Any]]()
    
    internal var basketList: [[String:Any]]? {
        didSet {
            self.changeHandler?(.didFetchBasket)
        }
    }
    
    func getBasket(_ completion: @escaping (Error?) -> Void) {
        
        basketList = []
        
        guard let uid = uid else {
            return
        }
        
        db.collection("users").document(uid).getDocument() { (querySnapshot, err) in
            guard (querySnapshot?.data()) != nil else {
                return
            }
            
            self.basketList = querySnapshot?.get("basket") as? [[String: Any]]
        }
    }
    
    //Call the current photo
    func productsForIndexPath(_ indexPath: IndexPath) -> [String : Any]? {
        return basketList?[indexPath.row]
    }
    
    var numberOfRows: Int {
        basketList?.count ?? .zero
    }

    
}
