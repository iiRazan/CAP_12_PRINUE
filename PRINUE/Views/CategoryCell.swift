//
//  CategoryCell.swift
//  PRINUE
//
//  Created by Razan on 26/05/1443 AH.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage : UIImageView!
    @IBOutlet weak var categoryTitle : UILabel!
    @IBOutlet weak var comingSoonLabel : UILabel!
    
    
    func setUpCategoryCell(categoryImg:UIImage, categoryType:String, comingSoon:String ) {
        categoryTitle.text = categoryType
        comingSoonLabel.text = comingSoon
        categoryImage.image = categoryImg
        
    }
}
