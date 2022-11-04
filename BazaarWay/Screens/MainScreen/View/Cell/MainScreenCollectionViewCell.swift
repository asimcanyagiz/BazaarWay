//
//  MainScreenCollectionViewCell.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 29.10.2022.
//

import UIKit

class MainScreenCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var cellStackView: UIStackView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var imagesView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Customize Cell
        //Customize ImageBorder
        imagesView.translatesAutoresizingMaskIntoConstraints = false
        imagesView.clipsToBounds = true
        cellStackView.layer.cornerRadius = 12
        cellStackView.layer.borderWidth = 1
        cellStackView.layer.borderColor = UIColor.lightGray.cgColor
    }

}
