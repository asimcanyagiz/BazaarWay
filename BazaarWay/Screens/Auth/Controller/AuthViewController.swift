//
//  AuthViewController.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 24.10.2022.
//

import UIKit
import FirebaseAuth
import Lottie

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
            submitButton.setTitle(title, for: .normal)
        }
    }
    
    
    //MARK: - UI ELEMENTS
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var animationStackView: UIStackView!
    
    
    //MARK: - UI ELEMENT Constraints
    @IBOutlet weak var userNameTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var repeatPasswordTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTopperConstraint: NSLayoutConstraint!
    @IBOutlet weak var authTopperConstraint: NSLayoutConstraint!
    
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
        setAnimation()
        
        //Control the inputs for cases and catch the results
        viewModel.changeHandler = { change in
            switch change {
            case .didErrorOccurred(let error):
                self.showError(error)
            case .didSignUpSuccessful:
                self.navigationController?.popViewController(animated: true)
                break
            }
        }
        
        title = "Auth"
        userNameTextField.isHidden = true
        repeatPasswordTextField.isHidden = true
        emailTopperConstraint.constant = 30
        authTopperConstraint.constant = 30
    }
    
    //MARK: - Functions
    
    @IBAction func didSegmentedButtonPressed(_ sender: UISegmentedControl) {
        
        let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        authType = AuthType(text: title ?? "Sign In")
        
        if title == "Sign In"{
            userNameTextField.isHidden = true
            repeatPasswordTextField.isHidden = true
            
            emailTextField.text = ""
            passwordTextField.text = ""
            
            emailTopperConstraint.constant = 30
            authTopperConstraint.constant = 30
        } else {
            userNameTextField.isHidden = false
            repeatPasswordTextField.isHidden = false
            
            emailTextField.text = ""
            passwordTextField.text = ""
            
            emailTopperConstraint.constant = 116
            authTopperConstraint.constant = 114
        }
    }
    
    @IBAction func didSubmitButtonPressed(_ sender: UIButton) {
        
        //inputs
        guard let credential = emailTextField.text,
              let password = passwordTextField.text,
              let username = userNameTextField.text else {
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
            if passwordTextField.text == repeatPasswordTextField.text {
                viewModel.signUp(email: credential,
                                 password: password,
                                 username: username)
            } else {
                self.showAlert(title: "Error", message: "Passwords must match!", cancelButtonTitle: nil, handler: nil)
            }
        }
    }
    
    func setAnimation(){
        var animationView = LottieAnimationView()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.frame = view.bounds
        animationView = .init(name: "auth")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        animationView.backgroundBehavior = .pauseAndRestore
        
        animationStackView.addArrangedSubview(animationView)
    }
}
