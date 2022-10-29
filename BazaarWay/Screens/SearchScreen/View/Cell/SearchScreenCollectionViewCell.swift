//
//  SearchScreenCollectionViewCell.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 28.10.2022.
//

import UIKit

class SearchScreenCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addButton.titleLabel?.text = "Add to Cart"
        addButton.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
        
        //Customize ImageBorder
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false
        imageViewCell.clipsToBounds = true
        imageViewCell.layer.cornerRadius = 12
        imageViewCell.layer.borderWidth = 1
        imageViewCell.layer.borderColor = UIColor.lightGray.cgColor
    }

}
