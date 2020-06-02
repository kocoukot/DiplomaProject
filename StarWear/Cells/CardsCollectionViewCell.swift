

import UIKit
import Alamofire
import AlamofireImage
import SVProgressHUD

class CardsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var oldPrice: UILabel!      
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var itemPic: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    private var parentUrl = "https://blackstarwear.ru/"
    
    func setItemInfo(_ itemInfo: ItemCards){
        itemName.text = itemInfo.name
        self.layer.cornerRadius = 10
        backGroundView.layer.cornerRadius = 10
        tagView.layer.cornerRadius = tagView.frame.width / 2 - 10        
        discountLabel.text = itemInfo.tag
        
        let labelList = [price!, oldPrice!, discountLabel!]
        
        CategoriesLoader().imageLoader(urlList: [itemInfo.mainImageURL], completion: {categories in
            self.itemPic.image  = categories.first
        })
        
        CommonHelpFuncs().priceUpdate(itemInfo.oldPrice, itemInfo.tag!, labelList, tagView)
        
        price.text = "\(Int(itemInfo.price)) руб."
    }
    
}
