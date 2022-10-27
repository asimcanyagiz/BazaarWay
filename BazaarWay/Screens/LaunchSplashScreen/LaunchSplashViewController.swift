//
//  LaunchSplashViewController.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 26.10.2022.
//

import UIKit

class LaunchSplashViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        
        _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(setScreenTransfer), userInfo: nil, repeats: false)
        self.navigationController?.navigationItem.hidesBackButton = true
    }

    @objc func setScreenTransfer(){
        let mainScreenViewModel = MainScreenViewModel()
        let mainScreenViewController = MainScreenViewController(viewModel: mainScreenViewModel)
        let authScreenViewModel = AuthViewModel()
        let authScreenViewController = AuthViewController(viewModel: authScreenViewModel)
        let profileScreenViewModel = ProfileScreenViewModel()
        let profileScreenViewController = ProfileScreenViewController(viewModel: profileScreenViewModel)
        
        let tabBarController = UITabBarController()
        mainScreenViewController.tabBarItem = UITabBarItem(title: "Products", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        authScreenViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        profileScreenViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        tabBarController.viewControllers = [mainScreenViewController, authScreenViewController, profileScreenViewController]
        
        tabBarController.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(tabBarController, animated: false)
    }

}
