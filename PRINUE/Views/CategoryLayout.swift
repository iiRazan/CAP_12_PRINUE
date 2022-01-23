//
//  CategoryLayout.swift
//  PRINUE
//
//  Created by Razan on 29/05/1443 AH.
//

import UIKit

class CategoryLayout : UICollectionViewFlowLayout {
    
    let w = (3 / 4) * UIScreen.main.bounds.width
    let h = (1 / 8) * UIScreen.main.bounds.width
    let spacing = (1 / 16) * UIScreen.main.bounds.width
    
    lazy var collectionview: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = self.spacing
        return collectionview
    }()
}
