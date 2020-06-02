//
//  CartTableViewCell.swift
//  StarWear
//
//  Created by Anton on 20.05.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit
import RealmSwift

class CartTableViewCell: UITableViewCell {
    private let realm = try! Realm()
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productOldPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sizeLabel.isHidden = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}




