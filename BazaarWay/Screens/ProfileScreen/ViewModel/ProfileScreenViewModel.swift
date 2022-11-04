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
                print("succesfully logout")
                controller.logButton.setTitle("Log In",for:.normal)
            } catch {
                controller.showError(error)
            }
            self.userStatus(controller: controller)
        }
        
    }
    
    func logIn(controller: ProfileScreenViewController) {
        let authViewModel = AuthViewModel()
        let authViewController = AuthViewController(viewModel: authViewModel)
        controller.navigationController?.pushViewController(authViewController, animated: true)
    }
    
    func userStatus(controller: ProfileScreenViewController){
        let user = Auth.auth().currentUser;
        if (user == nil) {
            // there is no user signed in when user is nil
            controller.logButton.setTitle("Log In",for:.normal)
            controller.userNameLabel.text = ""
            controller.emailLabel.text = ""
        } else {
            controller.logButton.setTitle("Log Out",for:.normal)
            controller.userNameLabel.text = user?.uid
            controller.emailLabel.text = user?.email
        }
    }
}
