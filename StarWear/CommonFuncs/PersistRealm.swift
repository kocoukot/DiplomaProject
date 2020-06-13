
import Foundation
import RealmSwift


class SaveProduct: Object{
    @objc dynamic var name = ""
    @objc dynamic var price = 0.0
    @objc dynamic var oldPrice = ""
    @objc dynamic var imageURL = ""
    @objc dynamic var size = ""
    @objc dynamic var categoryID = ""
    @objc dynamic var itemID = ""
    
}


class Persistence{
    static let shared = Persistence()
    private let userNameKey = "Persistence.totalAmount"
    var totalSavedPrice: Int?{
        set { UserDefaults.standard.set(newValue, forKey: userNameKey) }
        get { return UserDefaults.standard.integer(forKey: userNameKey) }
    }
}


class RealmDataOperations{
    private let realm = try! Realm()

    func dataCount() -> Int{
       var itemsAmount = 0
        if let data = realm.objects(SaveProduct.self).count as? Int{
            itemsAmount = data
        } else {
            itemsAmount = 0
        }
        return itemsAmount
    }
    
    func setLabelInfoInCart(index: Int,sizeLabel: UILabel, productNameLabel: UILabel,productPriceLabel: UILabel,productOldPriceLabel: UILabel, productImageView: UIImageView){
        if realm.objects(SaveProduct.self) != nil{
            let data = realm.objects(SaveProduct.self)
            if data[index].size != "" {
                sizeLabel.text = "Размер: \(data[index].size)"
            } else{
                sizeLabel.isHidden = true
            }
            productNameLabel.text = data[index].name
            productPriceLabel.text = "\(Int(data[index].price)) руб."
            
            if let itemOldPrice = Double(data[index].oldPrice){
                productOldPriceLabel.isHidden = false
                productOldPriceLabel.text = "\(Int(itemOldPrice)) руб."
                productPriceLabel.textColor = UIColor.red
            } else {
                productOldPriceLabel.isHidden = true
                productPriceLabel.textColor = UIColor.black
            }
            CategoriesLoader().imageLoader(urlList: [data[index].imageURL], completion: {categories in
                productImageView.image = categories.first
            })
        }
    }
    
    func saveRealmData(_ productInfo: ItemCards, selectedSize: String, categoryID: String){
        let saveProduct = SaveProduct()
        saveProduct.name = productInfo.name
        saveProduct.price = productInfo.price
        saveProduct.oldPrice = productInfo.oldPrice
        saveProduct.imageURL = productInfo.mainImageURL
        saveProduct.size = selectedSize
        saveProduct.categoryID = categoryID
        saveProduct.itemID = productInfo.IDkey
        try! realm.write{
            realm.add(saveProduct)
        }
    }
    
    func removeFromRealm(row: Int) -> Int {
        let data = realm.objects(SaveProduct.self)
        let price = data[row].price
        realm.beginWrite()
        realm.delete(data[row])
        try! realm.commitWrite()
        return Int(price)
    }
    
}
