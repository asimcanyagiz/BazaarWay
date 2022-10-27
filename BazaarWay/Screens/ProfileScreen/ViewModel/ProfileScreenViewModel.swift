//
//  ProfileScreenViewModel.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 27.10.2022.
//

import Foundation
import FirebaseAuth
import UIKit

final class ProfileScreenViewModel {
    
    
    func logOut(controller: ProfileScreenViewController) {
        
        controller.showAlert(title: "Warning",
                  message: "Are you sure to sign out?",
                  cancelButtonTitle: "Cancel") { _ in
            do {
                try Auth.auth().signOut()
                controller.navigationController?.popToRootViewController(animated: true)
            } catch {
                controller.showError(error)
            }
        }
    }
}
