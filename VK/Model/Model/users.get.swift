//
//  users.get.swift
//  VK
//
//  Created by Семён Винников on 15.12.2022.
//

import Foundation
import RealmSwift

// MARK: - VkUsersGet
struct VkUsersGet: Decodable {
    var response: [VkUsers]
}

// MARK: - VkUsers
class VkUsers: Object, Decodable {
    @Persisted var id: Int
    @Persisted var bdate: String?
    @Persisted var domain: String?
    @Persisted var city: String?
    @Persisted var country: String?
    @Persisted var photo_400_orig: String?
    @Persisted var status: String?
    @Persisted var sex: String
    @Persisted var first_name: String?
    @Persisted var last_name: String?
    var fullName: String {
        return (self.first_name != nil ? self.first_name! : "") + (self.last_name != nil ? " " + self.last_name! : "")
    }
    @Persisted var can_access_closed: Bool?
    @Persisted var is_closed: Bool?

    enum CodingKeys: String, CodingKey {
        case id, bdate, domain, city, country
        case photo_400_orig = "photo_400_orig"
        case status, sex
        case first_name = "first_name"
        case last_name = "last_name"
        case can_access_closed = "can_access_closed"
        case is_closed = "is_closed"
    }
    
    enum CityKeys: String, CodingKey {
        case id, title
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.bdate = try? container.decode(String?.self, forKey: .bdate)
        self.domain = try? container.decode(String?.self, forKey: .domain)
        
        let city = try? container.nestedContainer(keyedBy: CityKeys.self , forKey: .city)
        self.city = try city?.decode(String?.self, forKey: .title)

        let country = try? container.nestedContainer(keyedBy: CityKeys.self , forKey: .country)
        self.country = try country?.decode(String?.self, forKey: .title)
        
        self.photo_400_orig = try? container.decode(String?.self, forKey: .photo_400_orig)
        self.status = try? container.decode(String?.self, forKey: .status)
        let sex = try? container.decode(Int?.self, forKey: .sex)
        self.sex = sex == 1 ? "женский" : (sex == 2 ? "мужской" : "пол не указан")
        self.first_name = try? container.decode(String?.self, forKey: .first_name)
        self.last_name = try? container.decode(String?.self, forKey: .last_name)
        
    }
}

// MARK: - City
class City: Decodable {
    var id: Int
    var title: String
}

