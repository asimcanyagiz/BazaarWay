//
//  SearchScreenViewModel.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 27.10.2022.
//

import Foundation
import UIKit

final class SearchScreenViewModel {
    
    func addSearchBar(controller: SearchScreenViewController) -> UISearchBar{
        let searchBar:UISearchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = controller
        return searchBar
    }
}
