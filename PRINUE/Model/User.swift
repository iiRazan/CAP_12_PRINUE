//
//  User.swift
//  PRINUE
//
//  Created by Razan on 22/05/1443 AH.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User : Codable {
    let uid : String
    let firstname : String
    let lastname : String
    let email : String
    let isAdmin : Bool
//    let orders : [Order]
    var orders : [DocumentReference] = []
}
