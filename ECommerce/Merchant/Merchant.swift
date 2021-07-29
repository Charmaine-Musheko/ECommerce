//
//  Meal.swift
//  FoodTrackerTests
//
//  Created by Charmaine Musheko on 06/04/2021.
//

import UIKit
import os.log

class Merchant: NSObject, NSCoding {
   
    
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Types
    //Save and Load the Meal
    struct PropertyKey{
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //MARK: Initialization
     
    init?(name: String, photo: UIImage?, rating: Int) {
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
         
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }

        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating    }
  // To implement the encodeWithCoder NSCoding method
    //MARK: NSCoding// to be able to encode and decode itself and its properties
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        
       }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // the name is required. Ife we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        //Must call designated initializer
        self.init(name: name, photo: photo, rating: rating)
    }
    }
