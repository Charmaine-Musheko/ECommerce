//
//  ProductsViewController.swift
//  ECommerce
//
//  Created by Charmaine Musheko on 21/07/2021.
//

import UIKit

class ProductsViewController: UIViewController {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var profileImageUrl: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var shipping: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        //Set up views if editing an exisiting meal
        if let products = product {
            navigationItem.title = products.name
            nameLbl.text = products.name
            priceLbl.text  = "\(products.price))"
            
            let profileImageView: UIImageView = {
                let imageView = UIImageView()
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.layer.cornerRadius = 24
                imageView.layer.masksToBounds = true
                imageView.contentMode = .scaleAspectFill
                return imageView
            }()
            
//            if let profileImageUrl = products.profileImageUrl {
//                profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
//                
//            }
//            image.text = "\(products.image)"
        }        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as! ViewController
    }
    
    
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
