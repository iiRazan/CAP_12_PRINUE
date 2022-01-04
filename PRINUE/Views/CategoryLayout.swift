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
//        layout.sectionInset = .init(top: 0, left: self.spacing, bottom: 0, right: self.spacing)
        layout.minimumLineSpacing = self.spacing
//        layout.itemSize = .init(width: self.w, height: self.h)
        
        
        return collectionview
    }()
    
    
    
    
    
    
    
    
    //    var previousOffset: CGFloat = 0.0
    //    var currentCell = 0
    //
    //    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    //        guard let cv = collectionView else {
    //            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    //        }
    //
    //        let itemCount = cv.numberOfItems(inSection: 0)
    //
    //        if previousOffset > cv.contentOffset.x && velocity.x < 0.0 {
    //            currentCell = max(currentCell-1, 0)
    //        } else if previousOffset < cv.contentOffset.x && velocity.x > 0.0 {
    //            currentCell = min(currentCell+1, itemCount-1)
    //        }
    //        let w = cv.frame.width
    //        let itemW = itemSize.width
    //        let space = minimumLineSpacing
    //        let edge = (w - itemW - space*2) / 2
    //        let offset = (itemW + space) * CGFloat(currentCell) - (edge + space)
    //        previousOffset = offset
    //        return CGPoint(x: offset, y: previousOffset)
    //
    //    }
    
    
}
