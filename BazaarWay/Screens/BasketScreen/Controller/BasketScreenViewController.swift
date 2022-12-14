//
//  BasketScreenViewController.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 2.11.2022.
//

import UIKit
import Kingfisher
import FirebaseFirestore

final class BasketScreenViewController: UIViewController, AlertPresentable {
    
    //MARK: - Firebase Connect
    private let db = Firestore.firestore()
    private let defaults = UserDefaults.standard
    
    // MARK: - View Model
    private let viewModel: BasketScreenViewModel
    
    // MARK: - Init
    init(viewModel: BasketScreenViewModel) {
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
    @IBOutlet weak var closeButton: UIButton!
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Notifications from other pages
        NotificationCenter.default.addObserver(self, selector: #selector(reloadingData), name: Notification.Name("reloadData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showAlertForTime), name: Notification.Name("sendAlert"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBasket), name: Notification.Name("updateData"), object: nil)
        
        //collection delegates
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "BasketScreenCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        
        //Enums
        viewModel.getBasket { error in
            if let error = error {
                print(error)
            }
        }
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchBasket:
                self.totalCostLabel.text = self.viewModel.totalCost()
                self.collectionView.reloadData()
                
            case .didErrorOccurred(let error):
                print(String(describing: error))
            }
        }
        
        //UI changes
        closeButton.layer.cornerRadius = closeButton.frame.size.width / 2
        closeButton.clipsToBounds = true
        totalCostLabel.text = viewModel.totalCost()
    }
    
    //MARK: - Functions
    @objc func showAlertForTime (notification: NSNotification){
        self.showSuccess(informMessage: "Succesfully product removed from basket!")
        self.totalCostLabel.text = self.viewModel.totalCost()
    }
    
    @objc func reloadingData (notification: NSNotification){
        viewModel.getBasket { error in
            if let error = error {
                print(error)
            }
        }
    }

    @IBAction func didPurchaseButtonPressed(_ sender: UIButton) {
        self.showSuccess(informMessage: "This option will be avaible soon!")
    }
    
    @IBAction func didCloseButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Function for when quantity stepper pressed we update the product
    @objc func updateBasket(_ notification: NSNotification){
        guard let products = viewModel.productsForIndexPath(notification.userInfo!["index"] as! IndexPath) else {
            fatalError("Product not found")
        }
        
        let basketProduct = [
            "id": products["id"]!,
            "title": products["title"]!,
            "price": products["price"]!,
            "description": products["description"]!,
            "category": products["category"]!,
            "image": products["image"]!,
            "quantity": notification.userInfo!["quantityNumber"] as Any
        ] as [String : Any]?
        
        guard let id = basketProduct,
              let uid = defaults.string(forKey: UserDefaultConstants.uid.rawValue) else {
            return
        }
        viewModel.checkBasket(basketProductTitle: products["title"]! as! String, newProductId: id)
        
        db.collection("users").document(uid).updateData([
            "basket": FieldValue.arrayUnion([id])
        ])
        
        self.totalCostLabel.text = self.viewModel.totalCost()
        //We use this alerts for take a time from user so data can be reload succesfully because firebase sometimes work slowly
        self.showSuccess(informMessage: "Succesfully basket updated for see the changes reopen the basket")
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            if UIViewController.self != BasketScreenViewModel.self {
                self.dismiss(animated: true, completion: nil)
                _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { timer in
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                self.dismiss(animated: true, completion: nil)
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
            fatalError("Product not found")
        }
        
        //We use ! because already data
        cell.imageView.kf.setImage(with: URL(string: products["image"] as! String))
        cell.titleLabel.text = "\(products["title"]!)"
        cell.priceLabel.text = "\(products["price"]!)$"
        cell.quantityLabel.text = "\(products["quantity"]!)"
        cell.quantityStepperValue.value = products["quantity"] as! Double
        
        cell.index = indexPath
        
        return cell
    }
}

