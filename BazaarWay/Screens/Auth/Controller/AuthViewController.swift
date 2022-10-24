//
//  AuthViewController.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 24.10.2022.
//

import UIKit

final class AuthViewController: UIViewController {
    
    // MARK: - View Model
    private let viewModel: AuthViewModel
    
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
    }

}
