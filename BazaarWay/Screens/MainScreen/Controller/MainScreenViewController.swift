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
    
    
    @IBOutlet weak var collectionViewTop: UICollectionView!
    @IBOutlet weak var collectionViewJewelery: UICollectionView!
    @IBOutlet weak var collectionViewElectronics: UICollectionView!
    @IBOutlet weak var collectionViewMens: UICollectionView!
    @IBOutlet weak var collectionViewWomens: UICollectionView!
    @IBOutlet weak var collectionViewTodays: UICollectionView!
    
    
    //MARK: - Stack View
    
    @IBOutlet weak var stackViewButtons: UIStackView!
    
    @IBOutlet weak var stackViewUIView: UIView!
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        stackViewUIView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        
        
        viewModel.setBasketButton(controller: self)
        
        
        //collection delegates
        collectionViewTop.delegate = self
        collectionViewJewelery.delegate = self
        collectionViewElectronics.delegate = self
        collectionViewMens.delegate = self
        collectionViewWomens.delegate = self
        collectionViewTodays.delegate = self
        
        collectionViewTop.dataSource = self
        collectionViewJewelery.dataSource = self
        collectionViewElectronics.dataSource = self
        collectionViewMens.dataSource = self
        collectionViewWomens.dataSource = self
        collectionViewTodays.dataSource = self
        
        let nib = UINib(nibName: "MainScreenCollectionViewCell", bundle: nil)
        collectionViewTop.register(nib, forCellWithReuseIdentifier: "mainCell")
        collectionViewJewelery.register(nib, forCellWithReuseIdentifier: "mainCell")
        collectionViewElectronics.register(nib, forCellWithReuseIdentifier: "mainCell")
        collectionViewMens.register(nib, forCellWithReuseIdentifier: "mainCell")
        collectionViewWomens.register(nib, forCellWithReuseIdentifier: "mainCell")
        collectionViewTodays.register(nib, forCellWithReuseIdentifier: "mainCell")
        
        
        
        //network
        viewModel.fetchProducts()
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchProduct:
                self.collectionViewTop.reloadData()
                self.collectionViewJewelery.reloadData()
                self.collectionViewElectronics.reloadData()
                self.collectionViewMens.reloadData()
                self.collectionViewWomens.reloadData()
                self.collectionViewTodays.reloadData()
                
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
        if collectionView == self.collectionViewTodays {
            let screenWidth = UIScreen.main.bounds.width
            let widthScaleFactor = screenWidth
            let screenHeight = UIScreen.main.bounds.height
            let heightScaleFactor = screenHeight / 3
            
            return CGSize(width: widthScaleFactor, height: heightScaleFactor)
        }
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionViewTodays {
            return viewModel.numberOfRows
        }
        print("========")
        print(viewModel.numberOfRows2)
        return viewModel.numberOfRows2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewTodays {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainScreenCollectionViewCell
            
            // Set up cell
            guard let products = viewModel.productsForIndexPath(indexPath) else {
                fatalError("Photo not found")
            }
            
            //Catch photos with kingfisher
            cellA.imageView.kf.setImage(with: products.imageURL)
            cellA.titleLabel.text = products.title
            cellA.priceLabel.text = "\(products.price)$"
            
            return cellA
        } else if collectionView == self.collectionViewTop {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainScreenCollectionViewCell
            
            //             Set up cell
            guard let products = viewModel.productsForIndexPath2(indexPath) else {
                fatalError("Photo not found")
            }
            
            //Catch photos with kingfisher
            cellB.imageView.kf.setImage(with: products.imageURL)
            cellB.titleLabel.text = products.title
            cellB.priceLabel.text = "\(products.price)$"
            
            
            return cellB
        } else {
            let cellC = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainScreenCollectionViewCell
            
            //             Set up cell
            guard let products = viewModel.productsForIndexPath2(indexPath) else {
                fatalError("Photo not found")
            }
            
            //Catch photos with kingfisher
            cellC.imageView.kf.setImage(with: products.imageURL)
            cellC.titleLabel.text = products.title
            cellC.priceLabel.text = "\(products.price)$"
            
            
            return cellC
        }
        
    }
}
// MARK: - UICollectionViewDelegate
extension MainScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionViewTodays {
            
            // Set up cell
            guard let products = viewModel.productsForIndexPath(indexPath) else {
                fatalError("Photo not found")
            }
            let detailScreenViewModel = DetailScreenViewModel()
            let detailScreenViewController = DetailScreenViewController(viewModel: detailScreenViewModel)
            detailScreenViewController.products = products
            present(detailScreenViewController, animated: true, completion: nil)
        } else if collectionView == self.collectionViewTop {
            guard let products = viewModel.productsForIndexPath2(indexPath) else {
                fatalError("Photo not found")
            }
            let detailScreenViewModel = DetailScreenViewModel()
            let detailScreenViewController = DetailScreenViewController(viewModel: detailScreenViewModel)
            detailScreenViewController.products = products
            present(detailScreenViewController, animated: true, completion: nil)
        } else {
            guard let products = viewModel.productsForIndexPath2(indexPath) else {
                fatalError("Photo not found")
            }
            let detailScreenViewModel = DetailScreenViewModel()
            let detailScreenViewController = DetailScreenViewController(viewModel: detailScreenViewModel)
            detailScreenViewController.products = products
            
            present(detailScreenViewController, animated: true, completion: nil)
        }
        
    }
}
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
