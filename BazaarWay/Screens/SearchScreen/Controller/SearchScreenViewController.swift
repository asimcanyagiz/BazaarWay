//
//  SearchScreenViewController.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 27.10.2022.
//

import UIKit

final class SearchScreenViewController: UIViewController {
    
    // MARK: - View Model
    private let viewModel: SearchScreenViewModel
    
    // MARK: - Init
    init(viewModel: SearchScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Elements
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //SearchBar adaption
        stackView.addSubview(viewModel.addSearchBar(controller: self))
    }

}
// MARK: - UISearchResultsUpdating
extension SearchScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if let text = searchBar.text, textSearched.count > 1 {
        }
    }
}
