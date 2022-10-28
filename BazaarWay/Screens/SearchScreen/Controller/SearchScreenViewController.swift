//
//  SearchScreenViewController.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 27.10.2022.
//

import UIKit
import Kingfisher

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
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //collection delegates
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "SearchScreenCollectionViewCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        
        //SearchBar adaption
        stackView.addSubview(viewModel.addSearchBar(controller: self))
        
        viewModel.fetchProducts()
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchProduct:
                self.collectionView.reloadData()
                
            case .didErrorOccurred(let error):
                print(String(describing: error))
            }
        }
    }
    
    //MARK: - Functions
    @IBAction func didSegmentedButtonPressed(_ sender: UISegmentedControl) {
        let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        viewModel.fetchProducts(categoryText: title!)
        collectionView.reloadData()
    }
    
    
    
}



//MARK: - Delegates
extension SearchScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Cell sizes
        let screenWidth = UIScreen.main.bounds.width
        let scaleFactor = (screenWidth / 2) - 6

        return CGSize(width: scaleFactor, height: scaleFactor)
    }
}

extension SearchScreenViewController: UICollectionViewDelegate {
    func tableView(_ collectionView: UICollectionView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension SearchScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchScreenCollectionViewCell
        
        guard let photo = viewModel.productsForIndexPath(indexPath) else {
            fatalError("Photo not found")
        }

        //Catch photos with kingfisher
        cell.imageViewCell.kf.setImage(with: photo.imageURL)
        return cell
    }
}



// MARK: - UISearchResultsUpdating
extension SearchScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if let text = searchBar.text, textSearched.count > 1 {
        }
    }
}
