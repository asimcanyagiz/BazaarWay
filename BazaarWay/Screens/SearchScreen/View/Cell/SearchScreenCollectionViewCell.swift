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
    
    @IBOutlet weak var imagesView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Customize ImageBorder
        imagesView.translatesAutoresizingMaskIntoConstraints = false
        imagesView.clipsToBounds = true
        imagesView.layer.cornerRadius = 12
        imagesView.layer.borderWidth = 1
        imagesView.layer.borderColor = UIColor.lightGray.cgColor
    }

}
