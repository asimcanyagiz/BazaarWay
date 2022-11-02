//
//  MainScreenViewModel.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 26.10.2022.
//

import Foundation
import FirebaseFirestore




final class DetailScreenViewModel: UserDefaultsAccessible {
    
    //MARK: - Firebase Connect
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
    }
    
    
}
