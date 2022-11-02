//
//  MainScreenViewModel.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 26.10.2022.
//

import Foundation
import FirebaseFirestore


@objc
protocol addBasketDelegate: AnyObject {
    @objc optional func didErrorOccurred(_ error: Error)
    @objc optional func didPhotoAddedToFavorites()
}

final class DetailScreenViewModel: UserDefaultsAccessible {
    
    //MARK: - Firebase Connect
    weak var delegate: addBasketDelegate?
    private let db = Firestore.firestore()
    private let defaults = UserDefaults.standard
    
    
    
    
    //MARK: - Add Basket
    func addBasket(productsData: Products?) {
        let basketProduct = [
            "id": productsData?.id as Any,
            "title": productsData?.title as Any,
            "price": productsData?.price as Any,
            "description": productsData?.description as Any,
            "category": productsData?.category as Any,
            "image": productsData?.image as Any
        ] as [String : Any]?
        
        guard let id = basketProduct,
              let uid = defaults.string(forKey: UserDefaultConstants.uid.rawValue) else {
            return
        }
        
        db.collection("users").document(uid).updateData([
            "basket": FieldValue.arrayUnion([id])
        ])
        
        delegate?.didPhotoAddedToFavorites?()
    }
    
    //MARK: - Get Basket
    var basketList = [[String:Any]]()
    
    func getBasket(_ completion: @escaping (Error?) -> Void) {
        
        basketList = []
        
        guard let uid = uid else {
            return
        }
        db.collection("users").document(uid).getDocument() { (querySnapshot, err) in
            guard let data = querySnapshot?.data() else {
                return
            }
            
            self.basketList = querySnapshot?.get("basket") as! [[String: Any]]
            print(self.basketList)
            print(self.basketList.count)
        }
    }
    
}
