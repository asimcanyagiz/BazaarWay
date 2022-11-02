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
    
    //MARK: - Tabbar Setup
    func setBasketButton(controller: UIViewController){
        
        let basketButtonImage = UIImage(systemName: "basket")
        let basketBarButtonItem = UIBarButtonItem(image: basketButtonImage, style: .plain, target: self, action: #selector(basketButton))
        basketBarButtonItem.tintColor = .black
        
        controller.tabBarController?.navigationItem.rightBarButtonItem = basketBarButtonItem
    }
    
    @objc func basketButton(){
        let basketScreenViewModel = BasketScreenViewModel()
        let basketScreenViewController = BasketScreenViewController(viewModel: basketScreenViewModel)
        present(basketScreenViewController, animated: true, completion: nil)
        print("clicked")
    }
    

    @objc func setScreenTransfer(){
        let mainScreenViewModel = MainScreenViewModel()
        let mainScreenViewController = MainScreenViewController(viewModel: mainScreenViewModel)
        let searchScreenViewModel = SearchScreenViewModel()
        let searchScreenViewController = SearchScreenViewController(viewModel: searchScreenViewModel)
        let profileScreenViewModel = ProfileScreenViewModel()
        let profileScreenViewController = ProfileScreenViewController(viewModel: profileScreenViewModel)
        
        let tabBarController = UITabBarController()
        mainScreenViewController.tabBarItem = UITabBarItem(title: "Products", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        searchScreenViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        profileScreenViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        tabBarController.viewControllers = [mainScreenViewController, searchScreenViewController, profileScreenViewController]
        
        let basketButtonImage = UIImage(systemName: "basket")
        let basketBarButtonItem = UIBarButtonItem(image: basketButtonImage, style: .plain, target: self, action: #selector(basketButton))
        basketBarButtonItem.tintColor = .black
        
        tabBarController.navigationItem.rightBarButtonItem = basketBarButtonItem
        
        tabBarController.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(tabBarController, animated: false)
    }

}
