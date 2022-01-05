//
//  Product.swift
//  PRINUE
//
//  Created by Razan on 24/05/1443 AH.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Product : Codable {
    let productID : Int
    let category : String
    let price : Float
    let quantity : Int
    let Size : String
}
