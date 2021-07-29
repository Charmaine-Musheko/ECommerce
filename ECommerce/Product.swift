//
//  Product.swift
//  ECommerce
//
//  Created by Charmaine Musheko on 15/07/2021.
//

import Foundation

import UIKit
import os.log

class Product: NSObject{
    
  
    
  
    let name: String!
    let price: Double!
    let profileImageUrl: String?
    let shipping: Int?
  //  let description: String?

    init(name: String?, price: Double?, profileImageUrl: String?, shipping: Int?){
     
        self.name = name
        self.profileImageUrl = profileImageUrl
        self.price = price
        self.shipping = shipping
 //       self.description = description
    
        }
  
}


