//
//  HomeViewController.swift
//  PRINUE
//
//  Created by Razan on 22/05/1443 AH.
//

import UIKit
import FirebaseStorage



class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var menuViewBG: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    
    struct Category {
        let categoryImg : UIImage
        let categoryType : String
        let comingSoon : String
    }
    
    
    
    var arrCategory = [Category]()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryID", for: indexPath) as! CategoryCell
        categoryCell.categoryImage.layer.cornerRadius = 30
        categoryCell.categoryImage.layer.masksToBounds = true
        let category = arrCategory[indexPath.row]
        categoryCell.setUpCategoryCell(categoryImg: category.categoryImg, categoryType: category.categoryType, comingSoon: category.comingSoon)
        return categoryCell
    }
    
    
    @objc func OnTappedMenu() {
        //print("show now")
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.sideMenuView.transform = .identity
            self.menuViewBG.transform = .identity
            
        }
    }
    
    func moveToContact() {
        let vc = storyboard?.instantiateViewController(identifier: "ContactID") as! Contact_VC
        //else { return }
//        vc.modalTransitionStyle = .flipHorizontal
//        vc.modalPresentationStyle = .automatic
        //show(vc, sender: self)
        self.navigationController?.show(vc, sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        setUpSideMenu()
        arrCategory.append(Category(categoryImg:UIImage(named:"cups")!, categoryType: "CUPS", comingSoon: ""))
        arrCategory.append(Category(categoryImg:UIImage(named:"clothes")!, categoryType: "CLOTHES", comingSoon: "Coming Soon"))
        arrCategory.append(Category(categoryImg:UIImage(named:"boxes")!, categoryType: "BOXES", comingSoon: "Coming Soon"))
        arrCategory.append(Category(categoryImg:UIImage(named:"stickers")!, categoryType: "STICKERS", comingSoon: "Coming Soon"))
        //        sideMenuView.isHidden = true
        //        menuViewBG.isHidden = true
        //        setUpCollection()
        
        
    }
    
    
    func hideSideMenu() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseOut) { [self] in
            self.sideMenuView.transform = CGAffineTransform(translationX: -(self.sideMenuView.frame.width), y: 0)
            self.menuViewBG.transform = CGAffineTransform(translationX: -(self.menuViewBG.frame.width), y: 0)
        }
    }
    
    @objc func tapOutside(_ gesture: UIGestureRecognizer) {
        hideSideMenu()
    }
    
    func setUpSideMenu() {
       
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(OnTappedMenu))
        
        
//        self.navigationController?.navigationBar.topItem?.setLeftBarButton(menuButton, animated: true)
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = menuButton
        
        sideMenuView.transform = CGAffineTransform(translationX: -(sideMenuView.frame.width), y: 0)
        menuViewBG.transform = CGAffineTransform(translationX: -(menuViewBG.frame.width), y: 0)
        menuViewBG.layer.shadowOffset = CGSize (width: 1, height: -1)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutside))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
    }
    
    
    
    private func setUpCollection() {
        //        categoryCollectionView.collectionViewLayout = layout
        //        categoryCollectionView.contentInsetAdjustmentBehavior = .never
        categoryCollectionView.showsVerticalScrollIndicator = false
        categoryCollectionView.showsHorizontalScrollIndicator = false
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        categoryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        //        categoryCollectionView.
        //        layout.minimumLineSpacing = 10.0
        //        layout.minimumInteritemSpacing = 50.0
        //        view.addSubview(categoryCollectionView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print ("Whats happening?")
        let sideVC = segue.destination as! SideMenu_VC
        sideVC.delegate = self
    }
    
}


extension HomeViewController : SideMenuDelegate {
    
    func didSelectMenu(option: SideMenuOption) {
        
        hideSideMenu()
        //Thread.sleep(forTimeInterval: 3)
        switch option {
        case .Profile:
            print("Profile Selected")
        case .Orders:
            print("Contacts Selected")
        case .Contact:
            moveToContact()
        }
    }
}
