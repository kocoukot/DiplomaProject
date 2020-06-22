//
//  SizesTableViewCell.swift
//  StarWear
//
//  Created by Anton on 29.05.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit

class SizesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dontHaveLabel: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setTableInfo(_ allSizes:String,_ sizesHave: [SizesList]){
        dontHaveLabel.isHidden = false
        amountLabel.isHidden = true
        isUserInteractionEnabled = false
        sizeLabel.text = allSizes
        for i in 0..<sizesHave.count{
            var amount = 0
            if sizesHave[i].sizeQuantity > 0 {
                amount = sizesHave[i].sizeQuantity as Int
            }
            if allSizes == sizesHave[i].sizeName {
                if amount > 0{
                    if amount < 5 {
                        amountLabel.text = "\(amount) шт."
                        amountLabel.isHidden = false
                    }
                    dontHaveLabel.isHidden = true
                    isUserInteractionEnabled = true
                    break
                }
            }
        }
    }
}
