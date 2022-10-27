//
//  ProfileScreenViewController.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 27.10.2022.
//

import UIKit

class ProfileScreenViewController: UIViewController, AlertPresentable {
    
    // MARK: - View Model
    private let viewModel: ProfileScreenViewModel
    
    // MARK: - Init
    init(viewModel: ProfileScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didLogOutPressed(_ sender: UIButton) {
        viewModel.logOut(controller: self)
    }
    
    
    

}
