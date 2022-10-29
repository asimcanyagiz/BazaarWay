//
//  ProfileScreenViewController.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 27.10.2022.
//

import UIKit
import FirebaseAuth

class ProfileScreenViewController: UIViewController, AlertPresentable {
    
    //MARK: - UI ELEMENTS
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logButton: UIButton!
    
    
    
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

        viewModel.userStatus(controller: self)
    }
    override func viewWillAppear(_ animated: Bool) {

        viewModel.userStatus(controller: self)
    }
    
    
    @IBAction func didAuthButtonPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "Log In" {
            viewModel.logIn(controller: self)
        }else {
            viewModel.logOut(controller: self)
            
        }
    }
    
    

}
