import UIKit
import SVProgressHUD

class ItemsCollectionViewController: UIViewController {
    
    var subcategoryID = ""
    var viewTitle = ""
    
    private var urlString = "index.php?route=api/v1/products&cat_id="
    
    @IBOutlet weak var itemsCollectionView: UICollectionView!

    private var categories: [ItemCards] = []
    var mainImageTemp: UIImage?
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
            vc.nameForSize = nameForSize
            vc.categoryID = subcategoryID
            vc.urlImageList.append(categories[index.row].mainImageURL)
        }
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
