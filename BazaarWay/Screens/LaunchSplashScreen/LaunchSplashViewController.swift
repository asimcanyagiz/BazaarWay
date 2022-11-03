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
        
        _ = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(setScreenOnboarding), userInfo: nil, repeats: false)
        self.navigationController?.navigationItem.hidesBackButton = true
    }
    
    
    
    @objc func setScreenOnboarding() {
        let onboardingViewController = OnboardingViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        onboardingViewController.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(onboardingViewController, animated: false)
    }

}
