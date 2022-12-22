//
//  FriendImageViewCell.swift
//  VK
//
//  Created by Semen Vinnikov on 27.06.2022.
//

import UIKit

class FriendImageViewCell: UICollectionViewCell {
    
    
    @IBOutlet var imageFriend: UIImageView!
    
    
    
    @IBOutlet var likeControl: LikeControl!
    @IBOutlet var container: UIView!
    
    override func awakeFromNib() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 2
        container.addGestureRecognizer(tap)
    }

    @objc func handleTap(_ : UITapGestureRecognizer) {
        likeControl.isLike.toggle()

        if likeControl.isLike {
            likeControl.likeIcon.image = UIImage(systemName: "suit.heart.fill")
        } else {
            likeControl.likeIcon.image = UIImage(systemName: "heart")
        }

    }

}
