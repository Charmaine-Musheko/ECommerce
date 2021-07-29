//
//  ViewController.swift
//  ECommerce
//
//  Created by Charmaine Musheko on 15/07/2021.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAnalytics

class ViewController: UIViewController {
//
//    @IBOutlet weak var priceLbl: UILabel!
//    
//
//    @IBOutlet weak var photoImage: UIImageView!
//    @IBOutlet weak var nameLbl: UILabel!    @IBOutlet weak var productList: UITableView!
    @IBOutlet weak var productList: UITableView!
    


   var products = [Product]()
    private var productCollectionRef: CollectionReference!
    
    // A pair of jeggings
//    var jeggings: [String: Any] = [
//      AnalyticsParameterItemID: "SKU_123",
//      AnalyticsParameterItemName: "jeggings",
//      AnalyticsParameterItemCategory: "pants",
//      AnalyticsParameterItemVariant: "black",
//      AnalyticsParameterItemBrand: "Google",
//      AnalyticsParameterPrice: 9.99,
//    ]
//
//    // A pair of boots
//    var boots: [String: Any] = [
//      AnalyticsParameterItemID: "SKU_456",
//      AnalyticsParameterItemName: "boots",
//      AnalyticsParameterItemCategory: "shoes",
//      AnalyticsParameterItemVariant: "brown",
//      AnalyticsParameterItemBrand: "Google",
//      AnalyticsParameterPrice: 24.99,
//    ]
//
//    // A pair of socks
//    var socks: [String: Any] = [
//      AnalyticsParameterItemID: "SKU_789",
//      AnalyticsParameterItemName: "ankle_socks",
//      AnalyticsParameterItemCategory: "socks",
//      AnalyticsParameterItemVariant: "red",
//      AnalyticsParameterItemBrand: "Google",
//      AnalyticsParameterPrice: 5.99,
//    ]
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        productList.delegate = self
        productList.dataSource = self
        
//        if let product = products {
//            navigationItem.title = product.name
//            nameLbl.text = product.name
//            priceLbl.text = "\(product.price))"
//        }
//
        productCollectionRef = Firestore.firestore().collection("products")
      
    }
//    func viewItenList(){
//        // Add item indexes
//        jeggings[AnalyticsParameterIndex] = 1
//        boots[AnalyticsParameterIndex] = 2
//        socks[AnalyticsParameterIndex] = 3
//
//        // Prepare ecommerce parameters
//        var itemList: [String: Any] = [
//          AnalyticsParameterItemListID: "L001",
//          AnalyticsParameterItemListName: "Related products",
//        ]
//
//        // Add items array
//        itemList[AnalyticsParameterItems] = [jeggings, boots, socks]
//
//        // Log view item list event
//        Analytics.logEvent(AnalyticsEventViewItemList, parameters: itemList)
//    }
//    func selectedItem(selectedItem:String) {
//        // Prepare ecommerce parameters
//        var selectedItem: [String: Any] = [
//          AnalyticsParameterItemListID: "L001",
//          AnalyticsParameterItemListName: "Related products",
//        ]
//
//        // Add items array
//        selectedItem[AnalyticsParameterItems] = [jeggings]
//
//        // Log select item event
//        Analytics.logEvent(AnalyticsEventSelectItem, parameters: selectedItem)
//    }
//    
//    func viewItem(productDetails: String){
//        // Prepare ecommerce parameters
//        var productDetails: [String: Any] = [
//          AnalyticsParameterCurrency: "USD",
//          AnalyticsParameterValue: 9.99
//        ]
//
//        // Add items array
//        productDetails[AnalyticsParameterItems] = [jeggings]
//
//        // Log view item event
//        Analytics.logEvent(AnalyticsEventViewItem, parameters: productDetails)
//
//    }
    @IBAction func unwindToProduct(_sender: UIStoryboardSegue){
        
    }
    
    //This method lets you configure a view controller before it's presented
        override func viewWillAppear(_ animated: Bool) {
        productCollectionRef.getDocuments{ (snapshot, error) in
            if let err = error {
                debugPrint("Error fetcing docs: \(err)")
            } else {
                guard let snap = snapshot else {return}
                for document in snap.documents{
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let price = data["price"] as? Double ?? 0.00
                    let profileImageUrl = data["profileImageUrl"] as? String ?? ""
                    let shipping = data["shipping"] as? Int ?? 0
               //     let description = data["decription"] as? String ?? ""
                    let newProduct =  Product(name: name, price: price, profileImageUrl: profileImageUrl, shipping: shipping)
                    self.products.append(newProduct)
                    
                }
                self.productList.reloadData()
            }
        
        }
    }

}


extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell{
            cell.configureCell(products: products[indexPath.row])
            
            cell.imageView?.image = UIImage(named: "meal1")
//
//            if let profileImageUrl = products.profileImageUrl {
//                let url = NSURL(string: profileImageUrl)
//                URLSession.sharedSession().dataTaskWithUrl(url!, completionHandler: {(data, response, error) in
//                    if error != nil{
//                        print(error)
//                        return
//                    }
//                    dispatch_async(dispatch_get_main_queue(), {
//                    cell.imageView?.image = UIImage(data: data!)
//                    })
//                }).resume()
//            }
           //        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
           //
           //            //download hit an error so lets return out
           //            if let error = error {
           //                print(error)
           //                return
           //            }
            return cell
        }else{
            return UITableViewCell()        
        
    
            
        }
}
}
    
    
    


//extension ViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return productArray.count
////    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell {
////            cell.name.text = productArray[indexPath.row]
//         //   return cell
//        }//
//        return UITableViewCell()
//   // }
////
//
//}
