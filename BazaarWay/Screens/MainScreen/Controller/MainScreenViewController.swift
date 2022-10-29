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
    
    //MARK: - CollectionView
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.setBasketButton(controller: self)
        
        
        //collection delegates
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "MainScreenCollectionViewCell", bundle: nil)
        
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
        return viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainScreenCollectionViewCell
        
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
