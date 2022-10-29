//
//  AuthViewController.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 24.10.2022.
//

import UIKit
import FirebaseAuth

final class AuthViewController: UIViewController, AlertPresentable {
    
    // MARK: - View Model
    private let viewModel: AuthViewModel
    
    //Cases for auth screen calls
    enum AuthType: String {
        case signIn = "Sign In"
        case signUp = "Sign Up"
        
        init(text: String) {
            switch text {
            case "Sign In":
                self = .signIn
            case "Sign Up":
                self = .signUp
            default:
                self = .signIn
            }
        }
    }
    
    var authType: AuthType = .signIn {
        didSet {
            titleLabel.text = authType.rawValue
//            submitButton.setTitle(title, for: .normal)
        }
    }
    
    
    //MARK: - UI ELEMENTS
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Init
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Control the inputs for cases and catch the results
        viewModel.changeHandler = { change in
            switch change {
            case .didErrorOccurred(let error):
                self.showError(error)
            case .didSignUpSuccessful:
                print("SIGN UP SUCCESSFUL!")
            }
        }
        
        title = "Auth"
    }
    
    
    
    @IBAction func didSegmentedButtonPressed(_ sender: UISegmentedControl) {
        
        let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        authType = AuthType(text: title ?? "Sign In")
    }
    
    
    
    
    @IBAction func didSubmitButtonPressed(_ sender: UIButton) {
        
        //inputs
        guard let credential = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        switch authType {
        case .signIn:
            viewModel.signIn(email: credential,
                             password: password,
                             completion: { [weak self] in
                guard self != nil else { return }
                //Navigate to profilescreen
                self?.navigationController?.popViewController(animated: true)
                
            })
        case .signUp:
            viewModel.signUp(email: credential,
                             password: password)
        }
        
    }
    
    
    
    

}
