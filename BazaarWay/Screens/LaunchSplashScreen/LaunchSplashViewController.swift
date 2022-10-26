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
        
        let timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(setScreenTransfer), userInfo: nil, repeats: false)
    }

    @objc func setScreenTransfer(){
        
        let authViewModel = AuthViewModel()
        let authViewController = AuthViewController(viewModel: authViewModel)
//        authViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "person"), selectedImage: UIImage(named: "person"))
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [authViewController]
        self.navigationController?.pushViewController(tabBarController, animated: false)
        self.navigationController?.navigationItem.hidesBackButton = true
        tabBarController.navigationItem.hidesBackButton = true
    }

}
