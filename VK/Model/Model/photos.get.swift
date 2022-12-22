//
//  photos.get.swift
//  VK
//
//  Created by Семён Винников on 15.12.2022.
//

import Foundation
import RealmSwift

// MARK: - VkPhotosGet
class VkPhotosGet: Decodable {
    var response: VkPhotos
}

// MARK: - Response
class VkPhotos: Decodable {
    var count: Int
    var items: [VkPhoto]?
}

class VkPhoto: Object, Decodable {

    @Persisted var id: Int = 0
    @Persisted var owner_id: Int = 0
    @Persisted var url: String = ""
    @Persisted var count: Int = 0
    @Persisted var userLikes: Int = 0
    
    enum CodingKeys: String, CodingKey{
        case id
        case owner_id
        case likes
        case sizes
    }
  
    enum SizeKeys: String, CodingKey{
        case url
    }
    
    enum LikesKeys: String, CodingKey{
        case count
        case userLikes = "user_likes"
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.owner_id = try container.decode(Int.self, forKey: .owner_id)
        var sizeValues = try container.nestedUnkeyedContainer(forKey: .sizes)
        let firstSizeValue = try sizeValues.nestedContainer(keyedBy: SizeKeys.self)
        self.url = try firstSizeValue.decode(String.self, forKey: .url)
        let likeValues = try container.nestedContainer(keyedBy: LikesKeys.self, forKey: .likes)
        self.count = try likeValues.decode(Int.self, forKey: .count)
        self.userLikes = try likeValues.decode(Int.self, forKey: .userLikes)
    }
}
