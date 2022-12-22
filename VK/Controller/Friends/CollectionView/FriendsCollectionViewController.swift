//
//  FriendsCollectionViewController.swift
//  VK
//
//  Created by Семён Винников on 22.12.2022.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class FriendsCollectionViewController: UICollectionViewController {

    let session = Session.shared
    let vkApi = Service.shared
    
    var arrayFriends : [Friend]? = []
    
    var userId : Int = 0
    
    var photos = [VkPhoto]()
    
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        refresh.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        collectionView.addSubview(refresh)
        
        guard let realm = RealmHelper.getRealm() else { return }
        //print(realm.configuration.fileURL)
        
        //MARK: Проверка на существование объекта Photos в Realm
        let photos = realm.objects(VkPhoto.self).where {
            ($0.owner_id == self.userId)
        }
        
        if photos.isEmpty {
            self.refreshData(self)
        }
        else {
            self.setPhotos(Array(photos))
        }

    }
    
    private func setPhotos(_ photos: [VkPhoto]) {
        self.photos = photos
        self.collectionView.reloadData()
    }
    
    @objc private func refreshData(_ sender: AnyObject)  {
        vkApi.getImageUser(token: session.token, id: self.userId, completion: { [weak self] in
            
            guard let self = self else { return }
            
            guard let realm = RealmHelper.getRealm() else { return }
            
            let photos = realm.objects(VkPhoto.self)
            
            self.setPhotos(Array(photos))
            
            if self.refresh.isRefreshing {
                self.refresh.endRefreshing()
            }
        })
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //guard arrayFriends?.count ?? 0 > 0 else { preconditionFailure("Error casting FriendCollectionViewCell") }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionFriends", for: indexPath) as? FriendCollectionViewCell
        else {
            preconditionFailure("Error casting FriendCollectionViewCell")
        }
        
        let url = URL(string: photos[indexPath.row].url)
        if let data = try? Data(contentsOf: url!) {
            cell.imageFriend.image = UIImage(data: data)
        }
        cell.nameFriend.text = ""

        
        return cell
    
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard arrayFriends != nil else {
            return
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FriendsPhotoGalleryController") as! FriendsPhotoGalleryController

        var images = [UIImage]()
        for fr in photos {
            let url = URL(string: fr.url)
            if let data = try? Data(contentsOf: url!) {
                images.append(UIImage(data: data)!)
            }
        }
    
        //vc.modalPresentationStyle = .currentContext
        vc.images = images
        vc.myIndexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
