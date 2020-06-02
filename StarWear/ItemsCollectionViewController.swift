import UIKit
import SVProgressHUD

class ItemsCollectionViewController: UIViewController {
    
    var subcategoryID = ""
    var viewTitle = ""
    
    private var urlString = "https://blackstarwear.ru/index.php?route=api/v1/products&cat_id="
    
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    private var categories: [ItemCards] = []
    var mainImageTemp: UIImage?
    let sizes = [["XXS", "XS","S","M", "L", "XL","XXL"],["36","37","38","39","40","41","42","43","44","45"], ["1-2 лет","3 года","4 года","5 лет","6 лет","7 лет","8 лет","9-10 лет","11-12 лет"], ["36/38", "39/40", "41-43"], ["6","6+","7/8","7+/8+", "11","11 Pro","11 Pro Max","XR","XSMax (10SMax)", "X (10)/XS (10S)"], ["85 см","95 см","105 см","120 см","115 см"]]
    var nameForSize = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewTitle
        CategoriesLoader(urlString:urlString + String(subcategoryID)).loadItemsCards(completion: {cards in
            self.categories = cards
            self.itemsCollectionView.reloadData()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        SVProgressHUD.dismiss()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell, let index = itemsCollectionView.indexPath(for: cell), let vc = segue.destination as? ItemCardViewController, segue.identifier == "itemCard"{
            vc.productInfo = categories[index.row]
            switch nameForSize{
            case "Обувь":
                vc.sizes = sizes[1]
            case "Детская":
                vc.sizes = sizes[2]
            case "Носки":
                vc.sizes = sizes[3]
            case "Чехлы на телефоны":
                vc.sizes = sizes[4]
            case "Ремни":
                vc.sizes = sizes[5]
            default:
                vc.sizes = sizes[0]
            }
            witchSize()
            vc.categoryID = subcategoryID
            vc.urlImageList.append(categories[index.row].mainImageURL)
        }
    }
    
    func witchSize(){
//        nameForSize.removeFirst(16)
            print (nameForSize)
        
    }
    
}

extension ItemsCollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let w = UIScreen.main.bounds.size.width / 2 - 15
        return CGSize(width: w, height: w * 2 )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCard", for: indexPath) as! CardsCollectionViewCell
        cell.setItemInfo(categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemsCollectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
