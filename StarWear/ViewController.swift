//
//  ViewController.swift
//  StarWear
//
//  Created by Anton on 11.05.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController {
    private let realm = try! Realm()
    
    private var urlString = "https://blackstarshop.ru/index.php?route=api/v1/categories"
    @IBOutlet weak var categoriesTableView: UITableView!
    private var categories: [Categories] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        CategoriesLoader(urlString:urlString).loadCategories(completion: {categories in
            self.categories = categories
            self.categoriesTableView.reloadData()
        })
        if let data = realm.objects(SaveProduct.self).count as? Int{
            let viewconrollers = self.tabBarController?.viewControllers
            viewconrollers![1].tabBarItem.badgeValue = data > 0 ? "\(data)" : nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let index = categoriesTableView.indexPath(for: cell){
            
            if let vc = segue.destination as? SubCategoryViewController, segue.identifier == "SubCategoriesTable"{
                for n in 0..<categories[index.row].subcategories.count{
                    if let category = SubCategories(data: categories[index.row].subcategories[n]){
                        vc.tempSub.append(category)
                        vc.viewTitle = categories[index.row].name
                    }
                }
            }
            
            if let vc = segue.destination as? ItemsCollectionViewController, segue.identifier == "NoSubItemCollection"{
                vc.viewTitle = categories[index.row].name
                vc.subcategoryID = categories[index.row].IDkey
                vc.nameForSize = categories[index.row].name
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cellID = ""
        if categories[indexPath.row].subcategories.count > 0 {
            cellID = "CategoryCell"
        } else {
            cellID = "NoCategoryCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! CategoryTableViewCell
        cell.categoryLabel.text = categories[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


