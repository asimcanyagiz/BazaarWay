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
        stackView.addSubview(addSearchBar(controller: self))
        
        //api enums
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

//MARK: - Delegates
extension SearchScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Cell sizes
        let screenWidth = UIScreen.main.bounds.width
        let widthScaleFactor = (screenWidth / 2) - 6
        let screenHeight = UIScreen.main.bounds.height
        let heightScaleFactor = screenHeight / 4
        
        return CGSize(width: widthScaleFactor, height: heightScaleFactor)
    }
}

extension SearchScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let products = viewModel.productsForIndexPath(indexPath) else {
            fatalError("Photo not found")
        }
        let detailScreenViewModel = DetailScreenViewModel()
        let detailScreenViewController = DetailScreenViewController(viewModel: detailScreenViewModel)
        detailScreenViewController.products = products
        present(detailScreenViewController, animated: true, completion: nil)
    }
}

extension SearchScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchScreenCollectionViewCell
        
        guard let products = viewModel.productsForIndexPath(indexPath) else {
            fatalError("Photo not found")
        }
        
        //Catch photos with kingfisher
        cell.imageViewCell.kf.setImage(with: products.imageURL)
        cell.titleLabel.text = products.title
        cell.priceLabel.text = "\(products.price)$"
        cell.rateLabel.text = products.ratingToStar
        
        return cell
    }
}



// MARK: - UISearchResultsUpdating
extension SearchScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if let text = searchBar.text, textSearched.count > 1 {
            viewModel.products = viewModel.products?.filter({ $0.title.hasPrefix(text)})
            collectionView.reloadData()
        } else {
            viewModel.fetchProducts()
        }
    }
}
