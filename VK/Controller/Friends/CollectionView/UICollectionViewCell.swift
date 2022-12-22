//
//  UICollectionViewCell.swift
//  VK
//
//  Created by Семён Винников on 22.12.2022.
//

import UIKit
class FriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageFriend: UIImageView!
    
    @IBOutlet var nameFriend: UILabel!
    
    @IBOutlet var likeControl: LikeControl!
    
    @IBOutlet var container: UIView!
    
    //var cornerRadius: CGFloat = 5.0

        override func awakeFromNib() {
            super.awakeFromNib()
                
            // Apply rounded corners to contentView
            //contentView.layer.cornerRadius = cornerRadius
            contentView.layer.masksToBounds = true
            
            // Set masks to bounds to false to avoid the shadow
            // from being clipped to the corner radius
            //layer.cornerRadius = cornerRadius
            layer.masksToBounds = false
            
            // Apply a shadow
            layer.shadowRadius = 8.0
            layer.shadowOpacity = 0.10
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 5)
            
            //imageFriend.layer.cornerRadius = imageFriend.bounds.width / 6
            
//            let tapLike = UITapGestureRecognizer(
//                target: self, action: #selector(handleTapLike))
//            tapLike.numberOfTapsRequired = 2
//            container.addGestureRecognizer(tapLike)
            
        }
    
//        @objc func handleTapLike(sender: UITapGestureRecognizer) {
//
//            likeControl.islike.toggle()
//
//            if likeControl.islike {
//                likeControl.likePicture.tintColor = .red
//                likeControl.likePicture.image = UIImage(systemName: "suit.heart.fill")
//
//                let transformScale = CASpringAnimation(keyPath: "transform.scale")
//                let fadeOut = CABasicAnimation(keyPath: "opacity")
//
//                transformScale.fromValue = 0.5
//                transformScale.toValue = 1
//
//                fadeOut.fromValue = 0
//                fadeOut.toValue = 1
//
//                transformScale.stiffness = 20
//                transformScale.mass = 2
//                transformScale.duration = 1
//                transformScale.beginTime = CACurrentMediaTime()
//                transformScale.fillMode = CAMediaTimingFillMode.both
//                likeControl.likePicture.layer.add(transformScale, forKey: nil)
//
//                fadeOut.duration = 1
//                likeControl.likePicture.layer.add(fadeOut, forKey: nil)
//            }
//            else {
//
//
//                likeControl.likePicture.tintColor = .gray
//                likeControl.likePicture.image = UIImage(systemName: "suit.heart")
//
//                let groupAnimation = CAAnimationGroup()
//                groupAnimation.beginTime = CACurrentMediaTime()
//                groupAnimation.duration = 0.5
//
//                let scaleDown = CABasicAnimation(keyPath: "transform.scale")
//                scaleDown.fromValue = 2.0
//                scaleDown.toValue = 1.0
//                let fade = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
//                fade.fromValue = 0
//                fade.toValue = 1
//
//                groupAnimation.animations = [scaleDown,fade]
//                likeControl.likePicture.layer.add(groupAnimation, forKey: nil)
//            }
//
//
//        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            // Improve scrolling performance with an explicit shadowPath
//            layer.shadowPath = UIBezierPath(
//                roundedRect: bounds,
//                cornerRadius: cornerRadius
//            ).cgPath
        }
    

    
}
