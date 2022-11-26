//
//  Friend.swift
//  VK
//
//  Created by Semen Vinnikov on 27.06.2022.
//

import Foundation
import UIKit



struct MyFriend {
    let image: UIImage?
    let name: String
    
    let images: [ImagesFriend]
}


struct ImagesFriend {
    let image: UIImage?
}


let imageFriend = [
    ImagesFriend(image: UIImage(named: "sovaImage")),
    ImagesFriend(image: UIImage(named: "sova-image-1")),
    ImagesFriend(image: UIImage(named: "sova-image-2")),
    ImagesFriend(image: UIImage(named: "sova-image-3")),
    ImagesFriend(image: UIImage(named: "sova-image-4")),
    ImagesFriend(image: UIImage(named: "sova-image-5")),
    ImagesFriend(image: UIImage(named: "sova-image-6")),
    ImagesFriend(image: UIImage(named: "sova-image-7")),
    ImagesFriend(image: UIImage(named: "sova-image-8"))
]

let imageBeth = [
    ImagesFriend(image: UIImage(named: "sova-image-8")),
    ImagesFriend(image: UIImage(named: "sova-image-5")),
    ImagesFriend(image: UIImage(named: "sova-image-3")),
    ImagesFriend(image: UIImage(named: "sova-image-7"))
]
