//
//  MainScreenViewModel.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 26.10.2022.
//

import Foundation
import UIKit

final class MainScreenViewModel {
    
    
    //MARK: - Tabbar Setup
    
    func setBasketButton(controller: UIViewController){
        
        let basketButtonImage = UIImage(systemName: "basket")
        let basketBarButtonItem = UIBarButtonItem(image: basketButtonImage, style: .plain, target: self, action: #selector(basketButton))
        basketBarButtonItem.tintColor = .black
        
        controller.tabBarController?.navigationItem.rightBarButtonItem = basketBarButtonItem
    }
    
    @objc func basketButton(){
         print("clicked")
    }
}
