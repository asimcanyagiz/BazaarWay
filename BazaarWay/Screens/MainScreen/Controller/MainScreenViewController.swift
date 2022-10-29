//
//  MainScreenViewController.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 26.10.2022.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    
    // MARK: - View Model
    private let viewModel: MainScreenViewModel
    
    // MARK: - Init
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - CollectionViews
    @IBOutlet weak var collectionViewA: UICollectionView!
    
    @IBOutlet weak var collectionViewB: UICollectionView!
    
//    let collectionViewAIdentifier = "CollectionViewACell"
//    let collectionViewBIdentifier = "CollectionViewBCell"
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.setBasketButton(controller: self)
        
        
        //collection delegates
        collectionViewA.delegate = self
        collectionViewB.delegate = self
        
        collectionViewA.dataSource = self
        collectionViewB.dataSource = self
        let nib = UINib(nibName: "MainScreenCollectionViewCell", bundle: nil)
        collectionViewA.register(nib, forCellWithReuseIdentifier: "firstCell")
        let nib2 = UINib(nibName: "MainScreenCollectionViewCell2", bundle: nil)
        collectionViewB.register(nib2, forCellWithReuseIdentifier: "secondCell")
        
        
        
        //network
        viewModel.fetchProducts()
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchProduct:
                self.collectionViewA.reloadData()
                self.collectionViewB.reloadData()
                
            case .didErrorOccurred(let error):
                print(String(describing: error))
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem?.isHidden = true
    }
    
    @objc func basketButton(){
        print("clicked")
    }
}

extension MainScreenViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionViewA {
            return viewModel.numberOfRows
        }
        print("========")
        print(viewModel.numberOfRows2)
        return viewModel.numberOfRows2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewA {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath) as! MainScreenCollectionViewCell
            
            // Set up cell
            guard let products = viewModel.productsForIndexPath(indexPath) else {
                fatalError("Photo not found")
            }
            
            //Catch photos with kingfisher
            cellA.imageView.kf.setImage(with: products.imageURL)
            cellA.titleLabel.text = products.title
            cellA.priceLabel.text = "\(products.price)$"
            
            return cellA
        }
        
        else {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCell", for: indexPath) as! MainScreenCollectionViewCell2
            
//             Set up cell
            guard let products = viewModel.productsForIndexPath2(indexPath) else {
                fatalError("Photo not found")
            }

            //Catch photos with kingfisher
            cellB.imageView2.kf.setImage(with: products.imageURL)
            cellB.titleLabel2.text = products.title
            cellB.priceLabel2.text = "\(products.price)$"
            cellB.backgroundColor = .black
            
            
            return cellB
        }
        
    }
    
    
}
