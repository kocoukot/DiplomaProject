import UIKit

class SubCategoryViewController: UIViewController {
    @IBOutlet weak var subcategoriesTable: UITableView!

    var viewTitle = ""
    var category = ""
    var tempSub: [SubCategories] = []
    private var subCategories: [SubCategories] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewTitle
        for n in 0...tempSub.count - 1{
            if tempSub[n].type == "Category"{
                subCategories.append(tempSub[n])
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let index = subcategoriesTable.indexPath(for: cell), let vc = segue.destination as? ItemsCollectionViewController, segue.identifier == "itemCollection"{
            vc.subcategoryID = String(subCategories[index.row].id)
            vc.viewTitle = subCategories[index.row].name
            if subCategories[index.row].name == "Носки"  || subCategories[index.row].name == "Чехлы на телефоны" || subCategories[index.row].name == "Ремни"{
                vc.nameForSize = subCategories[index.row].name
            } else {
                vc.nameForSize = viewTitle
                
            }
        }
    }
}


extension SubCategoryViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return subCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryCell") as! CategoryTableViewCell
        cell.categoryLabel.text = subCategories[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
