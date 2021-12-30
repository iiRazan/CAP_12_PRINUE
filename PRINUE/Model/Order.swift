//
//  Order.swift
//  PRINUE
//
//  Created by Razan on 24/05/1443 AH.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Order : Codable {
    let orderID : String
    let status : String
    let products : [DocumentReference]
    let user : DocumentReference
}
