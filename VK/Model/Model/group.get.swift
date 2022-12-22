//
//  group.get.swift
//  VK
//
//  Created by Семён Винников on 15.12.2022.
//

import Foundation
import RealmSwift

class VkGroupResponse: Decodable {
    let response: VkGroups
}

class VkGroups: Decodable{
    let items: [VkGroup]
}

class VkGroup: Object, Decodable {
    @Persisted var name: String = ""
    @Persisted var photoGroup: String = ""
    @Persisted var Description: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case photoGroup = "photo_50"
        case Description = "description"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoGroup = try container.decode(String.self, forKey: .photoGroup)
        self.Description = try container.decode(String.self, forKey: .Description)
    }

}
