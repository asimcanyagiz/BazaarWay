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
    internal var basketList: [[String:Any]]? {
        didSet {
            self.changeHandler?(.didFetchBasket)
        }
    }
    
    //Function for get basket data
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
    
    //Function for remove products from basket data
    func removeBasket(basketProductTitle: String){
        
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
                NotificationCenter.default.post(name: Notification.Name("reloadData"), object: nil)
            }
        }
    }
    
    //Function for check products if exist remove from basket data
    func checkBasket(basketProductTitle: String, newProductId: Any){
        
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
                _ = Timer.scheduledTimer(withTimeInterval: 1.8, repeats: false) { timer in
                    NotificationCenter.default.post(name: Notification.Name("reloadData"), object: nil)
                }
                
            }
        }
    }
    
    func productsForIndexPath(_ indexPath: IndexPath) -> [String : Any]? {
        return basketList?[indexPath.row]
    }
    
    var numberOfRows: Int {
        basketList?.count ?? .zero
    }
    
    func totalCost() -> String {
        let total = basketList!.compactMap { (($0["price"] as? Double)!) * (($0["quantity"] as? Double)!)}.reduce(0, +)
        return String(format: "%.2f", total)
    }
    
    
}
