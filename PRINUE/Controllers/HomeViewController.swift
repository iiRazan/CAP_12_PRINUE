//
//  HomeViewController.swift
//  PRINUE
//
//  Created by Razan on 22/05/1443 AH.
//

import UIKit
import FirebaseStorage

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let storage = Storage.storage()
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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
//
//    func downloadAll() {
//        let folderUrl = "gs://styleyapp.appspot.com/Clothes"
//        let storageRef = Storage.storage().reference(forURL: folderUrl)
//
//        storageRef.listAll { result, error in
//          print ("Items in your Folder: ", result.items.count)
//          for item in result.items {
//            print ("name: ---: ", item.fullPath)
//
//            item.getData(maxSize: Int64.max) { data, err in
//
//
//              guard let data = data else { return }
//
//              let cloth = clothes(imgClothes: UIImage(data: data)!, textClothes: item.name)
//              self.arrClothes.append(cloth)
//
//              DispatchQueue.main.async {
//                self.clothesCV.reloadData()
//              }
//            }
//          }
//        }
}
