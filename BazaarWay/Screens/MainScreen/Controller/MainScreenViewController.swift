//
//  MainScreenViewController.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 26.10.2022.
//

import UIKit
import Lottie

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
    @IBOutlet weak var animationStack: UIStackView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAnimation()
        
        
        
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
    
    func setAnimation(){
        var animationView = LottieAnimationView()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.frame = view.bounds
        animationView = .init(name: "productsShop")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        animationView.backgroundBehavior = .pauseAndRestore
        
        animationStack.addArrangedSubview(animationView)
    }
    
}


//MARK: - Delegates
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
        
        switch collectionView {
        case collectionViewTop:
            return viewModel.numberOfRows
        case collectionViewJewelery:
            return viewModel.numberOfRowsJewelery
        case collectionViewElectronics:
            return viewModel.numberOfRowsElectronics
        case collectionViewMens:
            return viewModel.numberOfRowsMens
        case collectionViewWomens:
            return viewModel.numberOfRowsWomens
        case collectionViewTodays:
            return viewModel.numberOfRows
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainScreenCollectionViewCell
        
        switch collectionView {
        case collectionViewTop:
            // Set up cell
            guard let products = viewModel.productsForIndexPath(indexPath) else {
                fatalError("Photo not found")
            }
            //Catch photos with kingfisher
            cell.imageView.kf.setImage(with: products.imageURL)
            cell.titleLabel.text = products.title
            cell.priceLabel.text = "\(products.price)$"
            
            return cell
        case collectionViewJewelery:
            // Set up cell
            guard let products = viewModel.productsForIndexPathJewelery(indexPath) else {
                fatalError("Photo not found")
            }
            //Catch photos with kingfisher
            cell.imageView.kf.setImage(with: products.imageURL)
            cell.titleLabel.text = products.title
            cell.priceLabel.text = "\(products.price)$"
            
            return cell
        case collectionViewElectronics:
            // Set up cell
            guard let products = viewModel.productsForIndexPathElectronics(indexPath) else {
                fatalError("Photo not found")
            }
            //Catch photos with kingfisher
            cell.imageView.kf.setImage(with: products.imageURL)
            cell.titleLabel.text = products.title
            cell.priceLabel.text = "\(products.price)$"
            
            return cell
        case collectionViewMens:
            // Set up cell
            guard let products = viewModel.productsForIndexPathMens(indexPath) else {
                fatalError("Photo not found")
            }
            //Catch photos with kingfisher
            cell.imageView.kf.setImage(with: products.imageURL)
            cell.titleLabel.text = products.title
            cell.priceLabel.text = "\(products.price)$"
            
            return cell
        case collectionViewWomens:
            // Set up cell
            guard let products = viewModel.productsForIndexPathWomens(indexPath) else {
                fatalError("Photo not found")
            }
            //Catch photos with kingfisher
            cell.imageView.kf.setImage(with: products.imageURL)
            cell.titleLabel.text = products.title
            cell.priceLabel.text = "\(products.price)$"
            
            return cell
        case collectionViewTodays:
            // Set up cell
            guard let products = viewModel.productsForIndexPath(indexPath) else {
                fatalError("Photo not found")
            }
            //Catch photos with kingfisher
            cell.imageView.kf.setImage(with: products.imageURL)
            cell.titleLabel.text = products.title
            cell.priceLabel.text = "\(products.price)$"
            
            return cell
        default:
            return cell
        }
    }
}
// MARK: - UICollectionViewDelegate
extension MainScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case collectionViewTop:
            guard let products = viewModel.productsForIndexPath(indexPath) else {
                fatalError("Photo not found")
            }
            let detailScreenViewModel = DetailScreenViewModel()
            let detailScreenViewController = DetailScreenViewController(viewModel: detailScreenViewModel)
            detailScreenViewController.products = products
            present(detailScreenViewController, animated: true, completion: nil)
        case collectionViewJewelery:
            guard let products = viewModel.productsForIndexPathJewelery(indexPath) else {
                fatalError("Photo not found")
            }
            let detailScreenViewModel = DetailScreenViewModel()
            let detailScreenViewController = DetailScreenViewController(viewModel: detailScreenViewModel)
            detailScreenViewController.products = products
            present(detailScreenViewController, animated: true, completion: nil)
        case collectionViewElectronics:
            guard let products = viewModel.productsForIndexPathElectronics(indexPath) else {
                fatalError("Photo not found")
            }
            let detailScreenViewModel = DetailScreenViewModel()
            let detailScreenViewController = DetailScreenViewController(viewModel: detailScreenViewModel)
            detailScreenViewController.products = products
            present(detailScreenViewController, animated: true, completion: nil)
        case collectionViewMens:
            guard let products = viewModel.productsForIndexPathMens(indexPath) else {
                fatalError("Photo not found")
            }
            let detailScreenViewModel = DetailScreenViewModel()
            let detailScreenViewController = DetailScreenViewController(viewModel: detailScreenViewModel)
            detailScreenViewController.products = products
            present(detailScreenViewController, animated: true, completion: nil)
        case collectionViewWomens:
            guard let products = viewModel.productsForIndexPathWomens(indexPath) else {
                fatalError("Photo not found")
            }
            let detailScreenViewModel = DetailScreenViewModel()
            let detailScreenViewController = DetailScreenViewController(viewModel: detailScreenViewModel)
            detailScreenViewController.products = products
            present(detailScreenViewController, animated: true, completion: nil)
        default:
            guard let products = viewModel.productsForIndexPath(indexPath) else {
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
