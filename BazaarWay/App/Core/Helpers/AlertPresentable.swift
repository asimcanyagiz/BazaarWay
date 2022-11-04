//
//  AlertPresentable.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 27.10.2022.
//

import UIKit

protocol AlertPresentable { }

//With this protocol we can manage speacial alerts
extension AlertPresentable where Self: UIViewController {
    func showAlert(title: String? = nil,
                   message: String? = nil,
                   cancelButtonTitle: String? = nil,
                   handler: ((UIAlertAction) -> Void)? = nil ) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: handler)
        
        if let cancelButtonTitle = cancelButtonTitle {
            let cancelAction = UIAlertAction(title: cancelButtonTitle,
                                             style: .cancel)
            alertController.addAction(cancelAction)
        }
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true)
    }
    
    func showError(_ error: Error) {
        showAlert(title: "Error Occurred",
                  message: error.localizedDescription)
    }
    
    func showSuccess(){
        showAlert(title: "Succes",
                  message: "Deleted from basket")
    }
}
