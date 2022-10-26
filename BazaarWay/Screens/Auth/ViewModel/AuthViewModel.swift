//
//  AuthViewModel.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 24.10.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

//Cases for connect with firebase
enum AuthViewModelChange {
    case didErrorOccurred(_ error: Error)
    case didSignUpSuccessful
}

final class AuthViewModel {
    
    private let db = Firestore.firestore()
    private let defaults = UserDefaults.standard
    
    var changeHandler: ((AuthViewModelChange) -> Void)?
    
    //Function for signup
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.changeHandler?(.didErrorOccurred(error))
                return
            }
            
            //We create a User with User Model
            let user = User(username: authResult?.user.displayName,
                            email: authResult?.user.email,
                            basket: [])
            do {
                guard let data = try user.dictionary,
                      let id = authResult?.user.uid else {
                    return
                }
                
                self.defaults.set(id, forKey: "uid")
                
                self.db.collection("users").document(id).setData(data) { error in
                    
                    if let error = error {
                        self.changeHandler?(.didErrorOccurred(error))
                    } else {
                        self.changeHandler?(.didSignUpSuccessful)
                    }
                }
            } catch {
                self.changeHandler?(.didErrorOccurred(error))
            }
        }
    }
    
    //Sign up function
    func signIn(email: String,
                password: String,
                completion: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.changeHandler?(.didErrorOccurred(error))
                return
            }
            
            guard let id = authResult?.user.uid else {
                return
            }
            
            self.defaults.set(id, forKey: "uid")
            
            completion()
        }
    }
}
