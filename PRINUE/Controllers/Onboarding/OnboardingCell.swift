//
//  OnboardingCell.swift
//  PRINUE
//
//  Created by Razan on 20/06/1443 AH.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
   
    @IBOutlet weak var slideTitleLBL: UILabel!
    @IBOutlet weak var slideSubTitleLBL: UILabel!
    @IBOutlet weak var slideImage: UIImageView!
    
    func setup(_ slide: OnboardingSlides) {
        slideImage.image = slide.illustration
        slideTitleLBL.text = slide.titlle
        slideSubTitleLBL.text = slide.discription
        
    }
    
    
}
