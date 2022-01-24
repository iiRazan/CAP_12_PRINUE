//
//  YourOrder_VC.swift
//  PRINUE
//
//  Created by Razan on 06/06/1443 AH.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class YourOrder_VC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    let db = Firestore.firestore()
    var userOrders: [Order] = []
    var index: Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userOrders.count
    }
    
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userOrderID", for: indexPath) as! OrderTVC
        cell.orderNameLBL.text = "#\(userOrders[indexPath.row].orderName)"
        cell.orderView.layer.cornerRadius = 20
        index = indexPath.row
        return cell
    }
    

    @IBOutlet weak var orderTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderTableView.delegate = self
        orderTableView.dataSource = self
        orderTableView.separatorStyle = .none
        orderTableView.showsVerticalScrollIndicator = false
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userRef = db.collection("users").document(uid)
        
        db.collection("orders").whereField("forUser", isEqualTo: userRef).getDocuments { snapshot, err in
            if err == nil {
                guard let orders = snapshot?.documents else { return }
                for order in orders {
                    do {
                        guard let userOrder = try order.data(as: Order.self) else { return }
                        self.userOrders.append(userOrder)
                        self.orderTableView.reloadData()
    
                    } catch {
                        
                    
                    }
                }
            }
        }
        
    }
    
   
    
    @IBAction func deleteOnTapped(_ sender: Any) {
        
        
        db.collection("orders").document(Auth.auth().currentUser!.uid).updateData([
            "forUser": FieldValue.delete(),
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        orderTableView.reloadData()
    }
    
}
