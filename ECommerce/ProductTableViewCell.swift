//
//  ProductTableViewCell.swift
//  ECommerce
//
//  Created by Charmaine Musheko on 15/07/2021.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var descriptionlbl: UILabel!
    @IBOutlet weak var btnAddProduct: UIButton!
    @IBOutlet weak var btnRemoveProduct: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(products: Product){
    namelbl.text = products.name
        pricelbl.text  = "price: \(products.price)"
        imageView?.image = UIImage(named: "meal1")
        
        
        //        if let profileImageUrl = products.profileImageUrl {
//            profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)        }
//
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()

        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)

        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
//
//        addSubview(profileImageView)
//
//        //ios 9 constraint anchors
//        //need x,y,width,height anchors
//        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
//        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
//        profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//    }
//
}
