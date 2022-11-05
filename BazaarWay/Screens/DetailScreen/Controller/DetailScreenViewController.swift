//
//  DetailScreenViewController.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 1.11.2022.
//

import UIKit

final class DetailScreenViewController: UIViewController, AlertPresentable {
    
    // MARK: - View Model
    private let viewModel: DetailScreenViewModel
    
    // MARK: - Init
    init(viewModel: DetailScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Elements
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRatingStar: UILabel!
    @IBOutlet weak var productDetail: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    //MARK: - Product Data Set
    var products: Products?
    
    //MARK: - Life Cycle
    var quantity = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.kf.setImage(with: products?.imageURL)
        productTitle.text = products?.title
        productPrice.text = "\(products?.price ?? 404)$"
        productRatingStar.text = products?.ratingToStar
        productDetail.text = products?.description
        
        quantity = Int(quantityLabel.text!)!
        
        closeButton.layer.cornerRadius = closeButton.frame.size.width / 2
        closeButton.clipsToBounds = true
        
    }
    
    
    @IBAction func didStepperPressed(_ sender: UIStepper) {
        quantityLabel.text = String(Int(sender.value))
        quantity = Int(sender.value)
    }
    
    
    
    @IBAction func didAddButtonPressed(_ sender: UIButton) {
        viewModel.addBasket(productsData: products, quantity: quantity)
        self.showSuccess(informMessage: "Succesfully added to basket!")
        
    }
    
    
    @IBAction func didCloseButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
