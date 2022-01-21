//
//  DataManager.swift
//  PRINUE
//
//  Created by Razan on 03/06/1443 AH.
//

import UIKit
import Firebase
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
    
    static func getUserInfo(onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
            let ref = Database.database().reference()
            let defaults = UserDefaults.standard
            
            guard let uid = Auth.auth().currentUser?.uid else {
                print("User not found")
                return
            }
            
            ref.child("users").child(uid).observe(.value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : Any] {
                    let email = dictionary["email"] as! String
                    let firsname = dictionary["firsname"] as! String
                    
                    defaults.set(email, forKey: "userEmailKey")
                    defaults.set(firsname, forKey: "userNameKey")
                    
                    onSuccess()
                    print("------------------------firsname------------------------")
                }
            }) { (error) in
                print(error)
            }
        }
    
        
}
