
import Foundation
import Alamofire
import SVProgressHUD


protocol CategoriesDelegate{
    func loadedForcastWeather(categories: [Categories])
}

class CategoriesLoader{
    let parentUrl = "https://blackstarwear.ru/"
    let parentUrl2 = "https://blackstarshop.ru/"
    
    var urlString: String
    
    init(urlString: String = "") {
        self.urlString = urlString
    }
    
    func loadCategories(completion: @escaping ([Categories]) -> Void){
        let color =  UIColor(white: 1, alpha: 0)
        SVProgressHUD.setBackgroundColor(color)
        
        SVProgressHUD.show()
        Alamofire.request(urlString).responseJSON
            { response in
                if let object = response.result.value,
                    let jsonDict = object as? NSDictionary{
                    var categories:[Categories] = []
                    for (key ,data) in jsonDict where data is NSDictionary{
                        if let category = Categories(data: data as! NSDictionary, key: key as! String){
                            categories.append(category)
                        }
                    }
                    let sortedCategories = categories.sorted(by: { (Int1, Int2) -> Bool in
                        Int1.sortOrder < Int2.sortOrder
                    })
                    
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        completion(sortedCategories)
                    }
                }
        }
    }
    
    func loadItemsCards(completion: @escaping ([ItemCards]) -> Void){
        let color =  UIColor(white: 1, alpha: 0)
        SVProgressHUD.setBackgroundColor(color)
        SVProgressHUD.show()
        Alamofire.request(urlString).responseJSON
            { response in
                if let object = response.result.value,
                    let jsonDict = object as? NSDictionary{
                    var categories:[ItemCards] = []
                    for (key ,data) in jsonDict where data is NSDictionary{
                        if let category = ItemCards(data: data as! NSDictionary, key: key as! String){
                            categories.append(category)
                        }
                    }
                    let sortedCategories = categories.sorted(by: { (Int1, Int2) -> Bool in
                        Int1.sortOrder < Int2.sortOrder
                    })
                    
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        completion(sortedCategories)
                    }
                }
        }
    }
    
    
    func imageLoader(urlList: [String], completion: @escaping ([UIImage]) -> Void){
        var imagesList:[UIImage] = []
        for i in 0..<urlList.count{
            let url = "\(parentUrl)\(urlList[i])"
            
            Alamofire.request(url).responseImage { response in
                if case .success(let image) = response.result {
                    imagesList.append(image)
                }
                completion(imagesList)
            }
        }
    }
}
