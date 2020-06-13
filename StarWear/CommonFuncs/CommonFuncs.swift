//
//  CommonFuncs.swift
//  StarWear
//
//  Created by Anton on 22.05.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import Foundation
import UIKit

class CommonHelpFuncs{
    
    func priceUpdate(_ oldPrice: String,_ tag: String,_ labelList: [UILabel],_ tagView: UIView){
        // [price, oldPrice, discount]
        
        labelList[2].isHidden = false
        labelList[2].text = tag
        tagView.isHidden = false
        
        if let itemOldPrice = Double(oldPrice){
            tagView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            labelList[1].isHidden = false
            labelList[1].text = "\(Int(itemOldPrice)) руб."
            labelList[0].textColor = UIColor.red
        } else {
            labelList[1].isHidden = true
            labelList[0].textColor = UIColor.black
            switch tag {
            case "new":
                tagView.backgroundColor = UIColor(red: 0.204, green: 0.780, blue: 0.179, alpha: 1)
            case "Предзаказ":
                tagView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            default:
                labelList[2].isHidden = true
                tagView.isHidden = true
            }
        }   
    }
    
    func setSizesTable(sizeList: [SizesList], nameForSize: String, productInfo: ItemCards) -> [String]{
        var sizes: [String] = []
        if sizeList.count == 0 || sizeList.first?.sizeName == "Единый размер"  {
            sizes = []
        } else if sizeList[0].sizeName.contains("лет") || sizeList[0].sizeName.contains("года"){
            sizes = ["1-2 лет","3 года","4 года","5 лет","6 лет","7 лет","8 лет","9-10 лет","11-12 лет"]
        } else if sizeList[0].sizeName.contains("см") || sizeList[0].sizeName.contains("года"){
            sizes = ["85 см","95 см","105 см","115 см","120 см"]
        } else if nameForSize == "Обувь" {
            sizes = ["36","37","38","39","40","41","42","43","44","45"]
        } else if nameForSize == "Носки" {
            sizes = ["36/38", "39/40", "41-43"]
        } else if nameForSize == "Мужская" || nameForSize == "Женская" {
            sizes = ["XXS", "XS","S","M", "L", "XL","XXL"]
        } else{
            for i in 0..<(productInfo.offers.count ?? 0){
                sizes.append(sizeList[i].sizeName)
            }
        }
        return sizes
    }
    
    
    func setButtonShadow(button: UIButton){
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4.0
    }
}
