//
//  ProductsViewModel.swift
//  Tassel
//
//  Created by Charmaine Musheko on 12/07/2021.
//
//
//import Foundation
//import FirebaseFirestore
//class ProductsViewModel: ObservableObject{
//    @Published var products = [Product]()
//    private var db = Firestore.firestore()
//    
//    func fetchData(){
//        db.collection("products").addSnapshotListener {
//            (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//            self.products = documents.map {(queryDocumentSnapshot) -> Product in
//                let data = queryDocumentSnapshot.data()
//                
//                let reference = data["reference"] as? String ?? ""
//                let name = data["name"] as? String ?? ""
//                let price = data["price"] as? Double ?? 0.00
//                let image = data["image"] as? String ?? ""
//                let shipping = data["shipping"] as? Int ?? 0
//                let description = data["decription"] as? String ?? ""
//               
//                return Product(reference: reference, name: name, price: price, image: image, shipping: shipping, description: description)
//                
//            }
//        }
//    }
//    
//    
//}
