
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

