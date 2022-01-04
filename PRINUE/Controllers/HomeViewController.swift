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
    @IBOutlet weak var SideMenubtn: UIButton!
    
//    var screenWidth = UIScreen.main.bounds.size.width
//    let screenHeight = UIScreen.main.bounds.size.height
//    private let layout = CategoryLayout()
//    let storage = Storage.storage()
//    let storageRef = storage.reference()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryID", for: indexPath) as! CategoryCell
        categoryCell.categoryImage.layer.cornerRadius = 30
        categoryCell.categoryImage.layer.masksToBounds = true
//        categoryCell.comingSoonLabel.layer.cornerRadius = 30
//        categoryCell.categoryImage.image =
//        categoryCell.categoryTitle = ""
        return categoryCell
    }
    
    
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBAction func OnTappedMenu(_ sender: Any) {
        //print("show now")
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.sideMenuView.transform = .identity
            self.menuViewBG.transform = .identity
        }

//        sideMenuView.isHidden = false
//        menuViewBG.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuView.transform = CGAffineTransform(translationX: -(sideMenuView.frame.width), y: 0)
        menuViewBG.transform = CGAffineTransform(translationX: -(menuViewBG.frame.width), y: 0)
//        sideMenuView.isHidden = true
//        menuViewBG.isHidden = true
//        setUpCollection()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutside))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)

        
    }
    
    @objc
    func tapOutside(_ gesture: UIGestureRecognizer) {

        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseOut) { [self] in
            self.sideMenuView.transform = CGAffineTransform(translationX: -(self.sideMenuView.frame.width), y: 0)
            self.menuViewBG.transform = CGAffineTransform(translationX: -(self.menuViewBG.frame.width), y: 0)
        }
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
        
    func downloadAll() {
        let folderURL = "gs://prinue-95b91.appspot.com/category_images"
        let storageRef = Storage.storage().reference(forURL: folderURL)
        storageRef.listAll { result, error in
            print ("images:", result.items.count)
            for item in result.items {
                print ("name:__", item.fullPath)
                
//                item.getData(maxSize: Int64.max) { date, err in
//                    guard let data = data else { return }
//                    let category = CategoryCel()
                }
            }
        }
        
    }
    



