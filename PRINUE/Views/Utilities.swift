//
//  Utilities.swift
//  PRINUE
//
//  Created by Razan on 24/05/1443 AH.
//

import UIKit

extension UIView {
    func addShadow() {
        self.layer.cornerRadius = 20
        self.layer.shadowOffset = CGSize (width: -1, height: 1)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.4
        
    }
    
}

extension UIImageView {
    
    func loadFromUrl(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }.resume()
    }
}
