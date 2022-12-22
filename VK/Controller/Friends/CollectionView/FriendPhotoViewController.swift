//
//  FriendPhotoViewController.swift
//  VK
//
//  Created by Semen Vinnikov on 27.06.2022.
//

import UIKit
import RealmSwift

//private let reuseIdentifier = "Cell"

class FriendPhotoViewController: UICollectionViewController {
    
    //MARK: - Singletone
    let session = Session.shared
    let service = Service.shared
    
    var arrayFriends : [Friend]? = []
    
    var userId : Int = 0
    
    var photos = [VkPhoto]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //получение фото друзей
        service.getImageUser(token: session.token, id: self.userId, completion: { [weak self] in
            
            guard let self = self else { return }
            
            do {
                let realm = try Realm()
                let photos = realm.objects(VkPhoto.self)
                self.photos = Array(photos)
            } catch {
                print(error)
            }
            
            self.collectionView.reloadData()
            
        })
        
        
        // MARK: UICollectionViewDataSource
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of items
            return photos.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionFriends",
                                                                for: indexPath) as? FriendImageViewCell else {
                preconditionFailure("Error")
            }
            
            let url = URL(string: photos[indexPath.row].url)
            
            if let data  = try? Data(contentsOf: url!) {
                cell.imageFriend.image = UIImage(data: data)
            }

            
            //        cell.imageFriend.image = arrayImages[indexPath.row].image
            return cell
        }
        
        
        //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == "FriendPhotoBig",
        ////           let photoFriend = segue.destination as? FriendPhotoBigViewController,
        //           let selectedPhoto = collectionView.indexPathsForSelectedItems?.first {
        //
        ////            photoFriend.photos = friendPhotos
        ////            photoFriend.selectedPhotoIndex = selectedPhoto.row
        //        }
        //    }
        
        
        
        
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
}
