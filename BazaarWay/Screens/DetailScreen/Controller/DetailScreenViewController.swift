//
//  DetailScreenViewController.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 1.11.2022.
//

import UIKit

final class DetailScreenViewController: UIViewController {
    
    //MARK: - UI Elements
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRatingStar: UILabel!
    @IBOutlet weak var productDetail: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    //MARK: - Product Data Set
    var products: Products?

    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.kf.setImage(with: products?.imageURL)
        productTitle.text = products?.title
        productPrice.text = "\(products?.price ?? 404)$"
        productRatingStar.text = products?.ratingToStar
        productDetail.text = products?.description
    }
    
    
    
    @IBAction func didStepperPressed(_ sender: UIStepper) {
        quantityLabel.text = String(sender.value)
    }
    
    
    
    @IBAction func didAddButtonPressed(_ sender: UIButton) {
    }
    
    
    

}
