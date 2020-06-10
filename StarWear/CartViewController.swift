

import UIKit
import RealmSwift

class CartViewController: UIViewController {
    private let realm = try! Realm()

    @IBOutlet weak var buttomView: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
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
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return RealmDataOperations().dataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartTableViewCell
        cell.infoCellSet(index: indexPath.row)
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
            
            let viewconrollers = self.tabBarController?.viewControllers
            viewconrollers![1].tabBarItem.badgeValue = RealmDataOperations().dataCount() > 0 ? "\(RealmDataOperations().dataCount())" : nil
            
        }
    }
}

