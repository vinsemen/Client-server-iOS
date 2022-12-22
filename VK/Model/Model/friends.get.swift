//
//  WithWeb.swift
//  VK
//
//  Created by Семён Винников on 01.12.2022.
//

import Foundation

// MARK: - VkFriendsGet
struct VkFriendsGet: Codable {
    var response: VkFriendsGetResponse
}

// MARK: - VkFriendsGetResponse
struct VkFriendsGetResponse: Codable {
    var count: Int
    var items: [Int]
}





// получение информации о друзьях - количество, имя и фамилия, id, иконка
//struct Response: Codable {
//    var response: UserWeb
//}
//
//struct UserWeb: Codable {
//    var count: Int
//    var items: [FriendProperty]
//}
//
//struct FriendProperty: Codable {
//    var firstName: String
//    var id: Int
//    var lastName: String
//    var icon: String?
//
//    enum CodingKeys: String, CodingKey {
//        case firstName = "first_name"
//        case id
//        case lastName = "last_name"
//        case icon = "photo_100"
//    }
//}
//
//
//// получение фото друзей
//struct ResponsePhotosFriend: Codable {
//    var response: ResponsePhotos
//}
//
//struct ResponsePhotos: Codable {
//    var count: Int
//    var items: [FriendPhotos]
//}
//
//struct FriendPhotos: Codable {
//    var id: Int
//    var albumID: Int
//    var ownerID: Int
//    var sizes: [sizesPhotosFriend]
//    var text: String
//    var date: Int
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case albumID = "album_id"
//        case ownerID = "owner_id"
//        case sizes
//        case text
//        case date
//    }
//}
//
//struct sizesPhotosFriend: Codable {
//    var url: String
//}
