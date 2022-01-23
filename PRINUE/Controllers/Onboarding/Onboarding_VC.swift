//
//  Onboarding_VC.swift
//  PRINUE
//
//  Created by Razan on 13/06/1443 AH.
//

import UIKit

class Onboarding_VC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingID", for: indexPath) as! OnboardingCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
    
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var slides : [OnboardingSlides] = []
    
    let slide1 = OnboardingSlides(titlle: "Your PRINT is a press away!",
                                  discription: "printing online services",
                                  illustration: UIImage(named: "onboarding1")!)
    let slide2 = OnboardingSlides(titlle: "SAFE & SECURE",
                                  discription: "Keep your data private",
                                  illustration: UIImage(named: "onboarding2")!)
    let slide3 = OnboardingSlides(titlle: "HIGH QUALITY",
                                  discription: "impress your clients with a high quality printing product",
                                  illustration:UIImage(named: "onboarding3")!)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 10
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
        slides = [slide1,slide2,slide3]
        
        
    }
    
    
    @IBAction func nextOnTapped(_ sender: Any) {
        if currentPage == slides.count - 1 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginNavigationController") as! LoginNavigationController
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        }
    }
    
    
    
    
}

