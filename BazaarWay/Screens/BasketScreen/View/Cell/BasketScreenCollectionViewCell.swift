//
//  BasketScreenCollectionViewCell.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 2.11.2022.
//

import UIKit

class BasketScreenCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    @IBAction func didStepperPressed(_ sender: UIStepper) {
        quantityLabel.text = String(sender.value)
    }
    

}
