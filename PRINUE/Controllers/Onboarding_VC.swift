//
//  Onboarding_VC.swift
//  PRINUE
//
//  Created by Razan on 13/06/1443 AH.
//

import UIKit

class Onboarding_VC: UIViewController {
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
    
    
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var slides : [OnboardingSlides] = []
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 10

      
    }
    
    
    
    
    @IBAction func nextOnTapped(_ sender: Any) {
        
        
    }
    

   

}
