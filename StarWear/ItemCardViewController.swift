//
//  ItemCardViewController.swift
//  StarWear
//
//  Created by Anton on 18.05.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit
import RealmSwift



class ItemCardViewController: UIViewController, UIScrollViewDelegate {
    private let realm = try! Realm()
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemOldPriceLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var sizeButton: UIButton!
    
    @IBOutlet weak var viewScroll: UIView!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var sizeView: UIView!
    
    @IBOutlet weak var sizeTable: UITableView!
    
    @IBOutlet weak var imageScroll: UIScrollView!
    @IBOutlet weak var allScrol: UIScrollView!
    
    @IBOutlet weak var itemImagePageControl: UIPageControl!
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var sizeConstraint: NSLayoutConstraint!
    @IBOutlet weak var sizeHeightConstr: NSLayoutConstraint!
    
    
    private var parentUrl = "https://blackstarwear.ru/"
    var itemURLImage = UIImage()
    
    var productInfo: ItemCards? = nil
    var imagesList: [UIImage] = []
    var sizeList: [SizesList] = []
    var urlImageList: [String] = []
    var sizeIsChoosenBool = false
    var hasSizes = true
    var selectedSize = ""
    var categoryID = ""
    let yCoord = UIScreen.main.bounds.size.height
    let sizeWidth = UIScreen.main.bounds.size.width
    var sizes:[String] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        sizeConstraint.constant = yCoord
        self.blur.alpha = 0
        self.view.layoutIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageScroll.delegate = self
        self.title = productInfo?.name
        
        addToCartButton.layer.cornerRadius = 5
        tagView.layer.cornerRadius = tagView.frame.width / 2 - 10
        sizeButton.isHidden = false
        
        for i in 0..<(productInfo?.offers.count ?? 0){
            if let size = SizesList(data: productInfo!.offers[i] ){
                sizeList.append(size)
            }
        }
        
        self.sizeTable.reloadData()
        if sizeList.count == 0 || sizeList.first?.sizeName == "Единый размер"  {
            hasSizes = false
            sizeButton.isHidden = true
        }else{
            for i in 0..<productInfo!.productImages.count{
                urlImageList.append(productInfo!.productImages[i]["imageURL"]! as! String)
            }
        }
        itemCardSetInfo()
        itemImagePageControl.numberOfPages = urlImageList.count 
        itemImagePageControl.currentPage = 0
        viewScroll.bringSubviewToFront(itemImagePageControl)
        self.sizeTable.reloadData()
        
    }
    
    private func itemCardSetInfo(){
        itemNameLabel.text = productInfo?.name
        itemDescriptionLabel.text = productInfo?.description.replacingOccurrences(of: "&nbsp;", with: "\n")
        itemPriceSet()
        imagesLoading()
    }
    
    private func itemPriceSet(){
        discountLabel.text = productInfo?.tag
        itemPriceLabel.text = "\(Int(productInfo?.price ?? 0)) руб."
        let labelList = [itemPriceLabel!, itemOldPriceLabel!, discountLabel!]
        CommonHelpFuncs().priceUpdate(productInfo!.oldPrice, (productInfo?.tag)!, labelList, tagView)
    }
    
    private func imagesLoading(){
        CategoriesLoader().imageLoader(urlList: urlImageList, completion: {categories in
            self.imagesList = categories
            self.imageSet()
        })
    }
    
    private func imageSet(){        
        viewScroll.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width * 1.3)
        imageScroll.frame = viewScroll.frame
        for i in 0..<imagesList.count{
            let imageView = UIImageView()
            imageView.image = imagesList[i]
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.imageScroll.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition , y:  0, width: self.viewScroll.frame.width, height: self.imageScroll.frame.height)
            imageScroll.contentSize.width = imageScroll.frame.width * CGFloat(i + 1)
            imageScroll.addSubview(imageView)
        }
    }
    
    @IBAction func chooseSizeButton(_ sender: Any) {
        sizesShow()
    }
    
    @IBAction func addToCart(_ sender: Any) {
        if !hasSizes{
            addedToCart()
        } else {
            sizesShow()
        }
    }
    
    private func sizesShow(){
        UIView.animate(withDuration: 0.6, animations: {
            self.sizeConstraint.constant = self.yCoord - self.sizeView.frame.height - (self.tabBarController?.tabBar.frame.height)!
            self.blur.alpha = 1
            self.view.layoutIfNeeded()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.6, animations: {
            self.sizeConstraint.constant = self.yCoord + self.sizeView.frame.height
            self.blur.alpha = 0
            self.view.layoutIfNeeded()
        })
    }
    
    func listSave(){
        let saveProduct = SaveProduct()
        saveProduct.name = productInfo!.name
        saveProduct.price = productInfo!.price
        saveProduct.oldPrice = productInfo!.oldPrice
        saveProduct.imageURL = productInfo!.mainImageURL
        saveProduct.size = selectedSize
        saveProduct.categoryID = categoryID
        saveProduct.itemID = productInfo!.IDkey
        try! realm.write{
            realm.add(saveProduct)
        }
        Persistence.shared.totalSavedPrice! += Int(productInfo!.price)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round (imageScroll.contentOffset.x / viewScroll.frame.width)
        itemImagePageControl.currentPage = Int (pageIndex)
    }
    
    
    func addedToCart(){
        let viewconrollers = self.tabBarController?.viewControllers
        let inCart = Int(viewconrollers![1].tabBarItem.badgeValue ?? "") ?? 0
        viewconrollers![1].tabBarItem.badgeValue = "\(inCart + 1)"
        listSave()
    }
}


extension ItemCardViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return sizes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "sizeCell") as! SizesTableViewCell
        cell.sizeLabel.text = sizes[indexPath.row]
        cell.setTableInfo(sizes[indexPath.row], sizeList)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        sizeIsChoosenBool = true
        
        selectedSize = sizes[indexPath.row]
        sizeButton.setTitle("(\(selectedSize)) \(sizeButton.titleLabel!.text!)", for: UIControl.State.normal)
        UIView.animate(withDuration: 0.6, animations: {
            self.sizeConstraint.constant = self.yCoord + self.sizeView.frame.height
            self.blur.alpha = 0
            self.view.layoutIfNeeded()
        })
        addedToCart()
    }
}



