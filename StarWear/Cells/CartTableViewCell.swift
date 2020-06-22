//
//  CartTableViewCell.swift
//  StarWear
//
//  Created by Anton on 20.05.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productOldPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sizeLabel.isHidden = false
    }
    
    func infoCellSet(index: Int){
        RealmDataOperations().setLabelInfoInCart(index: index, sizeLabel: sizeLabel,productNameLabel: productNameLabel,productPriceLabel: productPriceLabel,productOldPriceLabel:productOldPriceLabel, productImageView:productImageView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}




