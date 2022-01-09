//
//  DataManager.swift
//  PRINUE
//
//  Created by Razan on 03/06/1443 AH.
//

import Foundation
import FirebaseFirestore

class DataManager {
    
    var allProducts = [Product]()
    
    static func getAllProduct(collectionName: String) -> [Product] {

        // Example
        let prod1 = Product(productID: 34, category: "some", price: 34.0, quantity: 2, Size: "Small")
        let prod2 = Product(productID: 34, category: "some", price: 34.0, quantity: 2, Size: "Small")
        
        return [prod1, prod2]
        
//        let db = Firestore.firestore()
//
//        // Get Data from FB
//        db.collection(collectionName).getDocuments { snapshot, error in
//            // Print something
//        }

        
        
    }
    
    static func getProduct(pid: String) -> Product {
        
        // fb
        let prod2 = Product(productID: 34, category: "some", price: 34.0, quantity: 2, Size: "Small")
        
        return prod2
        
    }
    
        
}
