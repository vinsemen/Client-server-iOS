//
//  Friend.swift
//  VK
//
//  Created by Semen Vinnikov on 27.06.2022.
//

import Foundation
import UIKit

class Friend {
    
    let name: String
    let avatar: UIImage?
    let allFriends: [Friend]?
    let allGroups: [Group]?

    init(name: String, avatar: UIImage? = nil, allFriends: [Friend]? = nil, allGroups: [Group]? = nil) {
        self.name = name
        self.avatar = avatar
        self.allFriends = allFriends
        self.allGroups = allGroups
    }

}






//struct MyFriend {
//    let image: UIImage?
//    let name: String
//
//    let images: [ImagesFriend]
//}
//
//
//struct ImagesFriend {
//    let image: UIImage?
//}

