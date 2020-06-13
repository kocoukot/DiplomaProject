

import Foundation
import UIKit

class Categories {
    let name: String
    let sortOrder: Int
    let subcategories: Array<NSDictionary>
    let iconImage: String
    let IDkey: String
    
    init?(data: NSDictionary, key: String){
        guard
            let IDkey = key as? String,
            let name = data["name"] as? String,
            let sortOrder = data["sortOrder"] as? String,
            let subcategories = data["subcategories"] as? Array<NSDictionary>,
            let iconImage = data["iconImage"] as? String
            else {
                return nil
        }
        self.IDkey = IDkey
        self.name = name
        self.sortOrder = Int(sortOrder) ?? 0
        self.subcategories = subcategories
        self.iconImage = iconImage
    }
}

class SubCategories{
    let id: Int
    let sortOrder: Int
    let name: String
    let iconImage: String
    let type: String
    
    init?(data: NSDictionary){
        guard
            let id = data["id"] as? String,
            let sortOrder = data["sortOrder"] as? String,
            let name = data["name"] as? String,
            let iconImage = data["iconImage"] as? String,
            let type = data["type"] as? String
            else {
                return nil
        }
        self.id = Int(id) ?? 0
        self.sortOrder = Int(sortOrder) ?? 0
        self.name = name
        self.iconImage = iconImage
        self.type = type
    }
}

class ItemCards{
    private var parentUrl = "https://blackstarwear.ru/"
    let description: String
    let sortOrder: Int
    let colorImageURL: String
    let mainImageURL: String
    let name: String
    let price: Double
    let productImages: Array<NSDictionary>
    let tag: String?
    let oldPrice: String
    let offers:[NSDictionary]
    let IDkey: String
    init?(data: NSDictionary, key: String){
        guard
            let IDkey = key as? String,
            let description = data["description"] as? String,
            let sortOrder = data["sortOrder"] as? String,
            let colorImageURL = data["colorImageURL"] as? String,
            let mainImage = data["mainImage"] as? String,
            let name = data["name"] as? String,
            let productImages = data["productImages"] as? Array<NSDictionary>,
            let tag = try? data["tag"] ?? "",
            let price = data["price"] as? String,
            let oldPrice = try? data["oldPrice"] ?? "",
            let offers = data["offers"] as? Array<NSDictionary>
            else {
                return nil
        }
        self.IDkey = IDkey
        self.description = description
        self.sortOrder = Int(sortOrder) ?? 0
        self.colorImageURL = colorImageURL
        self.name = name
        self.price = Double(price) ?? 0
        self.productImages = productImages
        self.tag = tag as? String ?? ""
        self.oldPrice = oldPrice as? String ?? ""
        self.mainImageURL = mainImage
        self.offers = offers
    }
}

class SizesList{
    let sizeName: String
    let sizeQuantity: Int
    init?(data: NSDictionary){
        guard
            let sizeName = data["size"] as? String,
            let sizeQuantity = data["quantity"] as? String
            else{
                return nil
        }
        self.sizeName = sizeName
        self.sizeQuantity = (Int(sizeQuantity)! > 0 ? Int (sizeQuantity) : 0) ?? 0
    }
}

