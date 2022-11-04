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
    func addBasket(productsData: Products?, quantity: Int) {
        let basketProduct = [
            "id": productsData?.id as Any,
            "title": productsData?.title as Any,
            "price": productsData?.price as Any,
            "description": productsData?.description as Any,
            "category": productsData?.category as Any,
            "image": productsData?.image as Any,
            "quantity": quantity as Any
        ] as [String : Any]?
        
        guard let id = basketProduct,
              let uid = defaults.string(forKey: UserDefaultConstants.uid.rawValue) else {
            return
        }
        removeBasket(basketProductTitle: productsData!.title, newProductId: id)
        
        db.collection("users").document(uid).updateData([
            "basket": FieldValue.arrayUnion([id])
        ])
    }
    
    func removeBasket(basketProductTitle: String, newProductId: Any){
        
        guard let uid = uid else {
            return
        }
        
        db.runTransaction { (trans, errorPointer) -> Any? in
            let doc: DocumentSnapshot
            let docRef = self.db.collection("users").document(uid)
            
            // get the document
            do {
                try doc = trans.getDocument(docRef)
            } catch let error as NSError {
                errorPointer?.pointee = error
                return nil
            }
            
            // get the items from the document
            if let items = doc.get("basket") as? [[String: Any]] {
                
                // find the element to delete
                if let toDelete = items.first(where: { (element) -> Bool in
                    
                    // the predicate for finding the element
                    if let title = element["title"] as? String,
                       title == basketProductTitle {
                        return true
                    } else {
                        return false
                    }
                }) {
                    // element found, remove it
                    docRef.updateData([
                        "basket": FieldValue.arrayRemove([toDelete])
                    ])
                }
            } else {
                // array itself not found
                print("items not found")
            }
            return nil // you can return things out of transactions but not needed here so return nil
        } completion: { (_, error) in
            if let error = error {
                print(error)
            } else {
                self.db.collection("users").document(uid).updateData([
                    "basket": FieldValue.arrayUnion([newProductId])
                ])
            }
        }
    }
    
    
}
