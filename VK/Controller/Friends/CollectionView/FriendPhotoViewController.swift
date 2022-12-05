//
//  FriendPhotoViewController.swift
//  VK
//
//  Created by Semen Vinnikov on 27.06.2022.
//

import UIKit

//private let reuseIdentifier = "Cell"

class FriendPhotoViewController: UICollectionViewController {
    
    //MARK: -Singletone
    let session = Session.shared
    let service = Service()
    
    var friendPhotos = [FriendPhotos]()
    
    //var arrayImages: [ImagesFriend] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //получение фото друзей
        service.getImageUser { answer in
            self.friendPhotos = answer.items
        }

    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return friendPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionFriends",
                                                            for: indexPath) as? FriendImageViewCell else {
            preconditionFailure("Error")
        }
        
        //cell.imageFriend.image = arrayImages[indexPath.row].image
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendPhotoBig",
           let photoFriend = segue.destination as? FriendPhotoBigViewController,
           let selectedPhoto = collectionView.indexPathsForSelectedItems?.first {

            //photoFriend.photos = friendPhotos
            photoFriend.selectedPhotoIndex = selectedPhoto.row
        }
    }
    
    


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
