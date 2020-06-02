//
//  CartViewController.swift
//  StarWear
//
//  Created by Anton on 20.05.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit
import RealmSwift

class CartViewController: UIViewController {
    private let realm = try! Realm()
    private var itemsAmount = 0
    private var parentUrl = "https://blackstarwear.ru/"
    private var urlString = "https://blackstarwear.ru/index.php?route=api/v1/products&cat_id="

    @IBOutlet weak var buttomView: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    var totalPrice = 0
    var productInfo: ItemCards? = nil

    @IBOutlet weak var makeOrderButton: UIButton!
    @IBOutlet weak var cartTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cartTable.reloadData()
        totalPriceLabel.text = "\(Persistence.shared.totalSavedPrice!) руб."
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        makeOrderButton.layer.cornerRadius = 5
        buttomView.layer.borderWidth = 1
        buttomView.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha: 1).cgColor
        
    }
    private func totalPriceCalc(){
        if realm.objects(SaveProduct.self) != nil{
            let data = realm.objects(SaveProduct.self)
            for i in 0...data.count-1{
                totalPrice += Int(data[i].price)
            }
        }
        totalPriceLabel.text = String(totalPrice)
    }
    
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let data = realm.objects(SaveProduct.self).count as? Int{
            itemsAmount = data
        } else {
            itemsAmount = 0
        }
        return itemsAmount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartTableViewCell
        if realm.objects(SaveProduct.self) != nil{
            let data = realm.objects(SaveProduct.self)
            cell.productNameLabel.text = data[indexPath.row].name
            cell.productPriceLabel.text = "\(Int(data[indexPath.row].price)) руб."
            if data[indexPath.row].size != "" {
                cell.sizeLabel.text = "Размер: \(data[indexPath.row].size)"
            } else{
                cell.sizeLabel.isHidden = true
            }
            if let itemOldPrice = Double(data[indexPath.row].oldPrice){
                cell.productOldPriceLabel.isHidden = false
                cell.productOldPriceLabel.text = "\(Int(itemOldPrice)) руб."
                cell.productPriceLabel.textColor = UIColor.red
                
            } else {
                cell.productOldPriceLabel.isHidden = true
                cell.productPriceLabel.textColor = UIColor.black
            }
            CategoriesLoader().imageLoader(urlList: [data[indexPath.row].imageURL], completion: {categories in
                cell.productImageView.image = categories.first
            })
            self.totalPrice += Int(data[indexPath.row].price)
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let data = realm.objects(SaveProduct.self)
            Persistence.shared.totalSavedPrice! -= Int(data[indexPath.row].price)
            totalPriceLabel.text = "\(Persistence.shared.totalSavedPrice!) руб."
            
            
            realm.beginWrite()
            realm.delete(data[indexPath.row])
            try! realm.commitWrite()
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            if let data = realm.objects(SaveProduct.self).count as? Int{
                let viewconrollers = self.tabBarController?.viewControllers
                viewconrollers![1].tabBarItem.badgeValue = data > 0 ? "\(data)" : nil
            }
        }
    }
}

