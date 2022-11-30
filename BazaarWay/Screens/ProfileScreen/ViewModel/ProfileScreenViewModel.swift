//
//  ProfileScreenViewModel.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 27.10.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class ProfileScreenViewModel: UserDefaultsAccessible {
    
    private let db = Firestore.firestore()
    private let defaults = UserDefaults.standard
    
   //MARK: - Firebase Auth operation functions
    func logOut(controller: ProfileScreenViewController) {
        
        controller.showAlert(title: "Warning",
                             message: "Are you sure to sign out?",
                             cancelButtonTitle: "Cancel") { _ in
            do {
                try Auth.auth().signOut()
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
        guard let uid = uid else {
            return
        }
        
        let user = Auth.auth().currentUser;
        if (user == nil) {
            // there is no user signed in when user is nil
            controller.logButton.setTitle("Log In",for:.normal)
            controller.userNameLabel.text = ""
            controller.emailLabel.text = ""
        } else {
            
            var username = "404"
            db.collection("users").document(uid).getDocument() { (document, error) in
                if let document = document, document.exists {
                    let property = document.get("username")
                    username = property as! String
                } else {
                    username = "404"
                }
            
            controller.logButton.setTitle("Log Out",for:.normal)
            controller.userNameLabel.text = username
            }
            controller.emailLabel.text = user?.email
        }
    }
}
