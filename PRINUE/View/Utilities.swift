//
//  Utilities.swift
//  PRINUE
//
//  Created by Razan on 22/05/1443 AH.
//

import UIKit

extension UIView {
    
    func addShadow() {
        self.layer.cornerRadius = 20
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.4
    }
    
//    func customButton() {
//        
//    }
}

