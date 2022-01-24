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
    let orderName : String
    let cupsType : String
    let cupSize : String
    let qyt : String
    let price : String
    let pdfFile : String? = String()
    let forUser : DocumentReference
}
