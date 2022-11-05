//
//  BasketScreenCollectionViewCell.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 2.11.2022.
//

import UIKit

class BasketScreenCollectionViewCell: UICollectionViewCell {
    
    let viewModel: BasketScreenViewModel = BasketScreenViewModel()
    let secondViewMode: DetailScreenViewModel = DetailScreenViewModel()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityStepperValue: UIStepper!
    
    var index: IndexPath = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    @IBAction func didStepperPressed(_ sender: UIStepper) {
        if sender.value == 0 {
            viewModel.removeBasket(basketProductTitle: titleLabel.text!)
            NotificationCenter.default.post(name: Notification.Name("sendAlert"), object: nil)
        } else {
            let number = Int(sender.value)
            NotificationCenter.default.post(name: Notification.Name("updateData"), object: nil, userInfo: ["quantityNumber" : number,
                                                                                                           "index" : index])
        }
        quantityLabel.text = String(Int(sender.value))
    }
    
    
}
