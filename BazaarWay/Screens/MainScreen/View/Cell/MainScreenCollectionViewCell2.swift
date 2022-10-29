//
//  MainScreenCollectionViewCell2.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 29.10.2022.
//

import UIKit

class MainScreenCollectionViewCell2: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var titleLabel2: UILabel!
    
    @IBOutlet weak var priceLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Customize Cell
        //Customize ImageBorder
        imageView2.translatesAutoresizingMaskIntoConstraints = false
        imageView2.clipsToBounds = true
        imageView2.layer.cornerRadius = 12
        imageView2.layer.borderWidth = 1
        imageView2.layer.borderColor = UIColor.lightGray.cgColor
    }

}
