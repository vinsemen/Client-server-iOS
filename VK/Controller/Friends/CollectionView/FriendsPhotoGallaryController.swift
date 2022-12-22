//
//  FriendsPhotoGallaryController.swift
//  VK
//
//  Created by Семён Винников on 22.12.2022.
//

import UIKit

class FriendsPhotoGalleryController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var images = [UIImage]()
    var myIndexPath: IndexPath!
    
    private let reuseIdentifier = "FriendPhotoCell"
    
    let countCells = 1
    
    var centerFlowLayout: SJCenterFlowLayout {
        return collectionView.collectionViewLayout as! SJCenterFlowLayout
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
       
        collectionView.performBatchUpdates(nil) { (result) in
            self.collectionView.scrollToItem(at: self.myIndexPath, at: .centeredHorizontally, animated: false)
        }
        
        centerFlowLayout.itemSize = CGSize(
            width: view.bounds.width * 0.8,
            height:  view.bounds.height * 0.4
        )
        
        centerFlowLayout.animationMode = SJCenterFlowLayoutAnimation.scale(sideItemScale: 0.7, sideItemAlpha: 0.7, sideItemShift: 0.0)
    }
    
}


extension FriendsPhotoGalleryController:UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        cell.photoImage.image = images[indexPath.item]
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let frameVC = collectionView.frame
//        let widthCell = frameVC.width / CGFloat(countCells)
//        let heigthCell = widthCell
//        return CGSize(width: widthCell, height: heigthCell)
//
//    }
    
}

