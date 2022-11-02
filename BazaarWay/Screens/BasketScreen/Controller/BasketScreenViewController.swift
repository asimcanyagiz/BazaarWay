//
//  BasketScreenViewController.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 2.11.2022.
//

import UIKit

final class BasketScreenViewController: UIViewController {
    
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
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //collection delegates
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "BasketScreenCollectionViewCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        
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
    
}

//MARK: - Delegates
extension BasketScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Cell sizes
        let screenWidth = UIScreen.main.bounds.width
        let widthScaleFactor = screenWidth / 1.2
        let screenHeight = UIScreen.main.bounds.height
        let heightScaleFactor = screenHeight / 8
        
        return CGSize(width: widthScaleFactor, height: heightScaleFactor)
    }
}

extension BasketScreenViewController: UICollectionViewDelegate {
    func tableView(_ collectionView: UICollectionView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension BasketScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BasketScreenCollectionViewCell
        
        guard let products = viewModel.productsForIndexPath(indexPath) else {
            fatalError("Photo not found")
        }
        
        //Catch photos with kingfisher
        cell.imageView.kf.setImage(with: products.imageURL)
        cell.titleLabel.text = products.title
        cell.priceLabel.text = "\(products.price)$"
        
        return cell
    }
}

