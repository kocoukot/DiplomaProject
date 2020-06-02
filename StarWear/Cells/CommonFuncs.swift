//
//  CommonFuncs.swift
//  StarWear
//
//  Created by Anton on 22.05.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire

class CommonHelpFuncs{
    
    func priceUpdate(_ oldPrice: String,_ tag: String,_ labelList: [UILabel],_ tagView: UIView){
        // [price, oldPrice, discount]
        
        labelList[2].isHidden = false
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
}
