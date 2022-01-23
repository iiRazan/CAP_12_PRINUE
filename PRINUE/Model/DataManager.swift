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
    
    
    static func getUserInfo(onSuccess: @escaping (_ user: User) -> Void, onError: @escaping (_ error: Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(uid)
        docRef.getDocument { snapshot, error in
            let result = snapshot?.data() as! [String: Any]
            do {
                if let user = try snapshot?.data(as: User.self) {
                    onSuccess(user)
                }
            } catch { print (error.localizedDescription) }
        }
        }
    
        
}
